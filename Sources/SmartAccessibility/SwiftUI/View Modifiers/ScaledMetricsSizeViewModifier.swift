import SwiftUI

public extension View {
    
    /// Scale the frame of the View according to `@ScaleMetric` and `@Environment(\.dynamicTypeSize)`.
    /// - Parameters:
    ///   - size: the size to scale.
    ///   - textStyle: the ancor system style.
    func scaledMetricsSize(
        size: CGSize,
        relativeTo textStyle: Font.TextStyle = .body
    ) -> some View {
        modifier(ScaledMetricsSizeViewModifier(size: size, relativeTo: textStyle))
    }
}

struct ScaledMetricsSizeViewModifier: ViewModifier {
    @Environment(\.accessibilityLimitedDynamicTypeSize) var limitedDynamicTypeSize
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    @ScaledMetric private var width: CGFloat
    @ScaledMetric private var height: CGFloat
    private let baseSize: CGSize
    
    init(
        size: CGSize,
        relativeTo textStyle: Font.TextStyle
    ) {
        baseSize = size
        self._width = .init(wrappedValue: size.width, relativeTo: textStyle)
        self._height = .init(wrappedValue: size.height, relativeTo: textStyle)
    }
    
    func body(content: Content) -> some View {
        let effectiveSize = min(systemDynamicTypeSize, limitedDynamicTypeSize)
        let scaledMetricSize: ScaledMetricsSize = .init(baseSize: baseSize, dynamicTypeSize: effectiveSize)
        let scaledSize = scaledMetricSize.make(scaledMetricsWidth: width, scaledMetricsHeight: height)
        
        content
            .aspectRatio(contentMode: .fit)
            .frame(
                idealWidth: scaledSize.width,
                maxWidth: scaledSize.width,
                idealHeight: scaledSize.height,
                maxHeight: scaledSize.height
            )
    }
}
