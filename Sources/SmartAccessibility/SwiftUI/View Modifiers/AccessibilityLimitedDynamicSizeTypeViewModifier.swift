import SwiftUI

public extension View {
    
    /// Constrains font growth to a specified "ceiling" and enables the Large Content Viewer when needed.
    ///
    /// Use this modifier to prevent a view from growing beyond a certain `DynamicTypeSize`, protecting the layout
    /// from breaking at extreme accessibility scales.
    ///
    /// If the system's size exceeds the limit AND the limit is an accessibility size (e.g., `.accessibility1`),
    /// the `.accessibilityShowsLargeContentViewer` is automatically enabled. This allows users to read
    /// the content via an HUD-style overlay during a long-press.
    ///
    /// - Parameter dynamicTypeSize: An optional specific limit for this view. If `nil`, the modifier
    ///   will look for a limit in the environment via `.accessibilityLimitedDynamicTypeSize`.
    ///
    /// - Note: The Large Content Viewer is only triggered if the limit is set to an accessibility size
    ///   and the system size has surpassed it.
    func accessibilityLimitedDynamicTypeSize(constrained dynamicTypeSize: DynamicTypeSize? = nil) -> some View {
        modifier(
            AccessibilityLimitedDynamicSizeTypeViewModifier(
                constrainedDynamicTypeSize: dynamicTypeSize
            )
        )
    }
}

struct AccessibilityLimitedDynamicSizeTypeViewModifier: ViewModifier {
    @Environment(\.accessibilityLimitedDynamicTypeSize) private var limitedDynamicTypeSize: DynamicTypeSize
    @Environment(\.dynamicTypeSize) private var systemDynamicTypeSize
    let constrainedDynamicTypeSize: DynamicTypeSize?
    
    private func getActualDynamicTypeSize() -> DynamicTypeSize {
        return constrainedDynamicTypeSize ?? limitedDynamicTypeSize
    }
    
    func body(content: Content) -> some View {
        let dynamicTypeSize = getActualDynamicTypeSize()
        let (applyLimit, isAccessibilitySize) = (systemDynamicTypeSize > dynamicTypeSize, dynamicTypeSize.isAccessibilitySize)
        
        switch (applyLimit, isAccessibilitySize) {
        case (true, true):
            content
                .dynamicTypeSize(...dynamicTypeSize)
                .accessibilityShowsLargeContentViewer()
        case (true, false):
            content
                .dynamicTypeSize(...dynamicTypeSize)
        default:
            content
        }
    }
}
