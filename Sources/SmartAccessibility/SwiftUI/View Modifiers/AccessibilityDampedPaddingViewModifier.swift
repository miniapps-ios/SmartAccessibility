import SwiftUI

public extension View {
    
    func accessibilityDampedPadding(
        _ padding: CGFloat,
        relativeTo textStyle: Font.TextStyle = .body
    ) -> some View {
        modifier(AccessibilityDampedPaddingViewModifier(padding: padding, relativeTo: textStyle))
    }
}

struct AccessibilityDampedPaddingViewModifier: ViewModifier {
    @Environment(\.accessibilityLimitedDynamicTypeSize) private var limitedDynamicTypeSize: DynamicTypeSize
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    @ScaledMetric private var scaledPadding: CGFloat
    private let basePadding: CGFloat
    
    init(
        padding: CGFloat,
        relativeTo textStyle: Font.TextStyle
    ) {
        self.basePadding = padding
        self._scaledPadding = .init(wrappedValue: padding, relativeTo: textStyle)
    }
    
    func body(content: Content) -> some View {
        let effectiveSize = min(systemDynamicTypeSize, limitedDynamicTypeSize)
        let dampedPadding: DampedPadding = .init(basePadding: basePadding, dynamicTypeSize: effectiveSize)
        let padding = dampedPadding.make(scaledMetrics: scaledPadding)
        
        content.padding(padding)
    }
}
