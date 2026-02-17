import Foundation

public enum SessionState: Equatable, Sendable {
    case idle
    case countdown(Int)
    case active(round: Int, phase: Int, timeLeft: Int)
    case paused(round: Int, phase: Int, timeLeft: Int)
    case complete
}

@MainActor
public final class BreathEngine {
    public private(set) var state: SessionState = .idle
    public private(set) var selectedPattern: BreathPattern?

    private var task: Task<Void, Never>?
    private let tickNanoseconds: UInt64
    private var shouldStop = false

    public init(tickNanoseconds: UInt64 = 1_000_000_000) {
        self.tickNanoseconds = tickNanoseconds
    }

    deinit {
        task?.cancel()
    }

    public func start(pattern: BreathPattern) {
        stop()
        shouldStop = false
        selectedPattern = pattern
        task = Task { [weak self] in
            guard let self else { return }
            await self.runSession(pattern: pattern)
        }
    }

    public func pause() {
        guard case let .active(round, phase, timeLeft) = state else { return }
        task?.cancel()
        state = .paused(round: round, phase: phase, timeLeft: timeLeft)
    }

    public func resume() {
        guard case let .paused(round, phase, timeLeft) = state,
              let pattern = selectedPattern else { return }
        task = Task { [weak self] in
            guard let self else { return }
            await self.resumeSession(pattern: pattern, round: round, phase: phase, timeLeft: timeLeft)
        }
    }

    public func stop() {
        shouldStop = true
        task?.cancel()
        task = nil
        state = .idle
    }

    private func runSession(pattern: BreathPattern) async {
        for remaining in stride(from: 3, through: 1, by: -1) {
            if Task.isCancelled || shouldStop { return }
            state = .countdown(remaining)
            try? await Task.sleep(nanoseconds: tickNanoseconds)
        }

        await runBreathLoop(pattern: pattern, startRound: 1, startPhase: 0, startTime: nil)
    }

    private func resumeSession(pattern: BreathPattern, round: Int, phase: Int, timeLeft: Int) async {
        await runBreathLoop(pattern: pattern, startRound: round, startPhase: phase, startTime: timeLeft)
    }

    private func runBreathLoop(pattern: BreathPattern, startRound: Int, startPhase: Int, startTime: Int?) async {
        for round in startRound...pattern.defaultRounds {
            let phaseStart = round == startRound ? startPhase : 0
            for phase in phaseStart..<pattern.phases.count {
                let duration = pattern.phases[phase].duration
                let initialTime = (round == startRound && phase == startPhase) ? (startTime ?? duration) : duration
                for second in stride(from: initialTime, through: 1, by: -1) {
                    if Task.isCancelled || shouldStop { return }
                    state = .active(round: round, phase: phase, timeLeft: second)
                    try? await Task.sleep(nanoseconds: tickNanoseconds)
                }
            }
        }
        if !shouldStop {
            state = .complete
        }
    }
}
