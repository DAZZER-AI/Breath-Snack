#if canImport(SwiftUI)
import SwiftUI
import BreatheSnackCore

public struct BreathOrbView: View {
    public let phaseType: PhaseType
    public let countdown: Int

    public init(phaseType: PhaseType, countdown: Int) {
        self.phaseType = phaseType
        self.countdown = countdown
    }

    public var body: some View {
        ZStack {
            TimelineView(.animation(minimumInterval: 1.0 / 60.0)) { _ in
                Canvas { context, size in
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    for index in 0..<3 {
                        let inset = CGFloat(index) * 18
                        let rect = CGRect(x: inset, y: inset, width: size.width - inset * 2, height: size.height - inset * 2)
                        context.stroke(Path(ellipseIn: rect), with: .color(orbColor.opacity(0.22 - Double(index) * 0.05)), lineWidth: 2)
                    }
                    context.fill(Path(ellipseIn: CGRect(x: 35, y: 35, width: size.width - 70, height: size.height - 70)), with: .radialGradient(.init(colors: [orbColor.opacity(0.95), orbColor.opacity(0.2)]), center: center, startRadius: 5, endRadius: size.width / 2))
                }
            }
            .frame(width: 280, height: 280)
            .scaleEffect(scale)
            .animation(.easeInOut(duration: 0.5), value: phaseType)

            VStack(spacing: 8) {
                Text(phaseType.rawValue.uppercased())
                    .font(BSFont.heading(16))
                    .foregroundStyle(.white)
                Text("\(countdown)")
                    .font(BSFont.heading(54))
                    .foregroundStyle(.white)
            }
        }
        .accessibilityLabel("\(phaseType.rawValue) \(countdown) seconds")
    }

    private var scale: CGFloat {
        switch phaseType {
        case .inhale: return 1.33
        case .hold: return 1.35
        case .exhale: return 1.0
        case .rest: return 0.95
        }
    }

    private var orbColor: Color {
        switch phaseType {
        case .inhale: return .orange
        case .hold: return .teal
        case .exhale: return .blue
        case .rest: return .mint
        }
    }
}
#endif
