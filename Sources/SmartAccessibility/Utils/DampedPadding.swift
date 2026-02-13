import SwiftUI

struct DampedPadding: ScaleDynamicTypeSizeProtocol {
    internal static let squareRootRatio: CGFloat = 2.0
    internal static let largeRatio: CGFloat = 0.6
    internal static let smallRatio: CGFloat = 0.45
    
    let basePadding: CGFloat
    let dynamicTypeSize: DynamicTypeSize
    
    func make(scaledMetrics: CGFloat) -> CGFloat {
        if dynamicTypeSize == .large { return basePadding }
        
        return scale(base: basePadding, scaledMetrics: scaledMetrics)
    }
}
