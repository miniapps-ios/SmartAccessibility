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
    /// Text("Edit")
    ///     .font(.system(size: 22, weight: .medium))
    ///     .foregroundStyle(.background)
    ///     .padding(.horizontal)
    ///     .scaledHeightContainer(baseFontSize: 22)
    ///     .background {
    ///         Capsule().fill(Color.pink)
    ///     }
    /// ```
    ///
    /// - Parameter baseFontSize: The fixed font size applied to the text, used as the reference point for scaling the container.
    func scaledHeightContainer(
        baseFontSize: CGFloat
    ) -> some View {
        modifier(ScaledHeightViewModifier(baseFontSize: baseFontSize))
    }
    
    /// Scales the view frame height proportionally according to the font text style.
    ///
    /// Use this modifier to maintain consistent proportions between a `Text` (configured with a fixed font text style)
    /// and its background container (e.g., a `Capsule` or `RoundedRectangle`).
    ///
    /// This is particularly useful in designs where the container must "hug" the text
    /// with a specific ratio, ensuring the background scales in sync when the user changes
    /// leaving the widht to expand and not to reduce below the height.
    ///
    /// ### Example
    /// ```swift
    /// Text("Done")
    ///     .font(.title2.bold())
    ///     .foregroundStyle(.background)
    ///     .padding(.horizontal)
    ///     .dynamicHeightContainer(textStyle: .title2)
    ///     .background {
    ///         Capsule().fill(Color.pink)
    ///     }
    /// ```
    ///
    /// - Parameter textStyle: The` Font.TextStyle` applied to the text, used as the reference point for scaling the container.
    func dynamicHeightContainer(
        textStyle: Font.TextStyle
    ) -> some View {
        self.modifier(DynamicHeightViewModifier(textStyle: textStyle))
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
            .padding(.horizontal)
            .frame(height: h)
            .frame(minWidth: h)
            .lineLimit(1)
    }
}

struct DynamicHeightViewModifier: ViewModifier {
    @Environment(\.accessibilityLimitedDynamicTypeSize) var limitedDynamicTypeSize
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    @ScaledMetric private var scaledMetrics: CGFloat
    let textStyle: Font.TextStyle
    
    init(textStyle: Font.TextStyle) {
        self.textStyle = textStyle
        self._scaledMetrics = .init(wrappedValue: textStyle.idealBaseHeight, relativeTo: textStyle)
    }
    
    func body(content: Content) -> some View {
        let effectiveSize = min(systemDynamicTypeSize, limitedDynamicTypeSize)
        let scaler: TypographyScaler = .init(dynamicTypeSize: effectiveSize)
        let h = scaler.make(with: textStyle, scaledMetrics: scaledMetrics)
        
        content
            .accessibilityDampedPadding(16, relativeTo: textStyle)
            .frame(height: h)
            .frame(minWidth: h)
    }
}
