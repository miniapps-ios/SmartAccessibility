import SwiftUI



public extension EnvironmentValues {
    
    var accessibilityLimitedDynamicTypeSize: DynamicTypeSize {
        get { self[AccessibilityLimitedDynamicTypeSizeEnvironmentKey.self] }
        set { self[AccessibilityLimitedDynamicTypeSizeEnvironmentKey.self] = newValue }
    }
}
