#if canImport(SwiftUI)
import SwiftUI

public enum BSFont {
    public static func heading(_ size: CGFloat) -> Font {
        Font.custom("AvenirNext-DemiBold", size: size)
    }

    public static func body(_ size: CGFloat) -> Font {
        Font.custom("AvenirNext-Regular", size: size)
    }
}

public enum BSColor {
    public static let background = Color(red: 0.07, green: 0.08, blue: 0.11)
    public static let card = Color.white.opacity(0.09)
    public static let accent = Color(red: 1.0, green: 0.48, blue: 0.2)
    public static let mist = Color.white.opacity(0.75)
}

public struct DynamicIslandSafeContainer<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        GeometryReader { geo in
            content
                .padding(.top, max(geo.safeAreaInsets.top + 8, 24))
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(BSColor.background.ignoresSafeArea())
        }
    }
}
#endif
