import XCTest
@testable import BreatheSnackCore

@MainActor
final class BreathEngineTests: XCTestCase {
    func testEngineCompletesStateMachine() async {
        let engine = BreathEngine(tickNanoseconds: 1_000_000)
        let pattern = BreathPattern(
            id: "test",
            name: "Test",
            imageName: "x",
            animationName: "y",
            category: .calm,
            phases: [
                BreathPhase(name: "In", duration: 1, type: .inhale, hapticProfile: .init(startIntensity: 0.2, endIntensity: 0.5)),
                BreathPhase(name: "Out", duration: 1, type: .exhale, hapticProfile: .init(startIntensity: 0.2, endIntensity: 0.5))
            ],
            defaultRounds: 1,
            orbColorScheme: .init(primaryHex: "#000", secondaryHex: "#111"),
            researchCitation: "n/a"
        )

        engine.start(pattern: pattern)
        try? await Task.sleep(nanoseconds: 40_000_000)

        XCTAssertEqual(engine.state, .complete)
    }

    func testPauseAndResume() async {
        let engine = BreathEngine(tickNanoseconds: 1_000_000)
        let pattern = BreathCatalog.patterns[0]
        engine.start(pattern: pattern)

        try? await Task.sleep(nanoseconds: 5_000_000)
        engine.pause()

        if case .paused = engine.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Engine should be paused")
        }

        engine.resume()
        try? await Task.sleep(nanoseconds: 10_000_000)

        XCTAssertNotEqual(engine.state, .idle)
    }

    func testStopResetsToIdle() async {
        let engine = BreathEngine(tickNanoseconds: 1_000_000)
        engine.start(pattern: BreathCatalog.patterns[1])
        engine.stop()

        XCTAssertEqual(engine.state, .idle)
    }
}
