import SwiftUI

struct ScaledMetricsSize: ScaleDynamicTypeSizeProtocol {
    internal static let squareRootRatio: CGFloat = 1.0
    internal static let largeRatio: CGFloat = 0.3
    internal static let smallRatio: CGFloat = 0.225
    
    let baseSize: CGSize
    let dynamicTypeSize: DynamicTypeSize
    
    func make(
        scaledMetricsWidth: CGFloat,
        scaledMetricsHeight: CGFloat
    ) -> CGSize {
        if dynamicTypeSize == .large {
            return baseSize
        }
        
        return CGSize(
            width: scale(base: baseSize.width, scaledMetrics: scaledMetricsWidth),
            height: scale(base: baseSize.height, scaledMetrics: scaledMetricsHeight)
        )
    }
}
