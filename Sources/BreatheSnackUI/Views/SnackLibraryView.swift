#if canImport(SwiftUI)
import SwiftUI
import BreatheSnackCore

public struct SnackLibraryView: View {
    public let patterns: [BreathPattern]

    public init(patterns: [BreathPattern]) {
        self.patterns = patterns
    }

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    public var body: some View {
        DynamicIslandSafeContainer {
            VStack(alignment: .leading, spacing: 14) {
                Text("Snack Menu")
                    .font(BSFont.heading(28))
                    .foregroundStyle(.white)

                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(patterns) { pattern in
                        VStack(alignment: .leading, spacing: 8) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(BSColor.card)
                                    .frame(height: 90)
                                Image(pattern.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 42)
                                Circle()
                                    .stroke(BSColor.accent.opacity(0.5), lineWidth: 1.5)
                                    .scaleEffect(1.15)
                                    .opacity(0.6)
                                    .animation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true), value: pattern.id)
                            }
                            Text(pattern.name)
                                .font(BSFont.heading(14))
                                .foregroundStyle(.white)
                                .lineLimit(2)
                            Text("\(pattern.totalDuration)s")
                                .font(BSFont.body(12))
                                .foregroundStyle(BSColor.mist)
                        }
                    }
                }
            }
        }
    }
}
#endif
