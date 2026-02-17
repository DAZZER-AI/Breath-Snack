#if canImport(SwiftUI)
import SwiftUI

public struct SplashLoginView: View {
    public init() {}

    public var body: some View {
        DynamicIslandSafeContainer {
            VStack(spacing: 18) {
                Spacer().frame(height: 12)
                Text("BreatheSnack")
                    .font(BSFont.heading(34))
                    .foregroundStyle(.white)
                Text("Micro-recovery for peak days")
                    .font(BSFont.body(15))
                    .foregroundStyle(BSColor.mist)

                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThinMaterial)
                    .overlay(alignment: .topLeading) {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Welcome back")
                                .font(BSFont.heading(22))
                            TextField("Email", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                            SecureField("Password", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                            Button("Start your breath snack") {}
                                .buttonStyle(.borderedProminent)
                                .tint(BSColor.accent)
                        }
                        .padding(20)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)

                Spacer()
            }
        }
    }
}
#endif
