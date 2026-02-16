import SwiftUI

public extension View {
    
    /// Scales the view frame size proportionally according to the environment's `imageScale`.
    ///
    /// Use this modifier to maintain consistent proportions between an `Image` (configured with a fixed `.font()`)
    /// and its background container (e.g., a `ZStack`, `Circle`, or `RoundedRectangle` with aspect ratio 1).
    ///
    /// This is particularly useful in designs where the container must "hug" the icon
    /// with a specific ratio, ensuring the background scales in sync when the user changes
    /// the system-wide `Image.Scale` (`.small`, `.medium`, or `.large`).
    ///
    /// ### Example
    /// ```swift
    /// ZStack {
    ///     RoundedRectangle(cornerRadius: 30)
    ///         .fill(Color.pink)
    ///
    ///     Image(systemName: "person.fill")
    ///         .font(.system(size: 64))
    ///         .foregroundStyle(.background)
    /// }
    /// .scaledContainer(baseFontSize: 64)
    /// ```
    ///
    /// - Parameter baseFontSize: The fixed font size applied to the image, used as the reference point for scaling the container.
    func scaledContainer(
        baseFontSize: CGFloat
    ) -> some View {
        modifier(ScaledContainerViewModifier(baseFontSize: baseFontSize))
    }
    
    /// Scales the view frame height proportionally according to the font size.
    ///
    /// Use this modifier to maintain consistent proportions between a `Text` (configured with a fixed font size)
    /// and its background container (e.g., a `Capsule` or `RoundedRectangle`).
    ///
    /// This is particularly useful in designs where the container must "hug" the text
    /// with a specific ratio, ensuring the background scales in sync when the user changes
    /// leaving the widht to expand and not to reduce below the height.
    ///
    /// ### Example
    /// ```swift
    /// ZStack {
    ///     Capsule()
    ///         .fill(Color.pink)
    ///
    ///     Text("Edit")
    ///         .font(.system(size: 22))
    ///         .foregroundStyle(.background)
    /// }
    /// .scaledHeightContainer(baseFontSize: 22)
    /// ```
    ///
    /// - Parameter baseFontSize: The fixed font size applied to the text, used as the reference point for scaling the container.
    func scaledHeightContainer(
        baseFontSize: CGFloat
    ) -> some View {
        modifier(ScaledHeightViewModifier(baseFontSize: baseFontSize))
    }
    
    /// Scales the view frame height proportionally according to the font size.
    ///
    /// Use this modifier to maintain consistent proportions between a `Text` (configured with a fixed font size)
    /// and its background container (e.g., a `Capsule` or `RoundedRectangle`).
    ///
    /// This is particularly useful in designs where the container must "hug" the text
    /// with a specific ratio, ensuring the background scales in sync when the user changes
    /// leaving the widht to expand and not to reduce below the height.
    ///
    /// ### Example
    /// ```swift
    /// ZStack {
    ///     Capsule()
    ///         .fill(Color.pink)
    ///
    ///     Text("Edit")
    ///         .font(.title2)
    ///         .foregroundStyle(.background)
    /// }
    /// .smartHeightContainer(source: .dynamyc(.title2))
    /// ```
    ///
    /// - Parameter source: The` ScaleFontSource` applied to the text, used as the reference point for scaling the container.
    func smartHightContainer(source: ScaleFontSource) -> some View {
        self.modifier(SmartHeightViewModifier(source: source))
    }
}

struct ScaledContainerViewModifier: ViewModifier {
    @Environment(\.imageScale) private var imageScale
    
    let baseFontSize: CGFloat
    
    func body(content: Content) -> some View {
        let imageScaleRatio = ImageScaler(imageScale: imageScale).ratio
        let fontRatio = 2 * imageScaleRatio
        let w = baseFontSize * fontRatio
        
        content.frame(width: w, height: w)
    }
}

struct ScaledHeightViewModifier: ViewModifier {
    let baseFontSize: CGFloat
    
    func body(content: Content) -> some View {
        let h = baseFontSize * 2
        
        content
            .frame(height: h)
            .frame(minWidth: h)
            .lineLimit(1)
    }
}

struct SmartHeightViewModifier: ViewModifier {
    @Environment(\.accessibilityLimitedDynamicTypeSize) var limitedDynamicTypeSize
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    
    let source: ScaleFontSource
    
    func body(content: Content) -> some View {
        let h: CGFloat = {
            switch source {
            case .fixed(let size):
                return size * 2
            case .dynamic(let style):
                let effectiveSize = min(systemDynamicTypeSize, limitedDynamicTypeSize)
                let scaler: TypographyScaler = .init(dynamicTypeSize: effectiveSize)
                return scaler.make(with: style)
            }
        }()
        
        content
            .frame(height: h)
            .frame(minWidth: h)
    }
}
