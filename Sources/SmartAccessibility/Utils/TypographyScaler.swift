import SwiftUI

struct TypographyScaler: ScaleDynamicTypeSizeProtocol {
    internal static let squareRootRatio: CGFloat = 4.0
    internal static let largeRatio: CGFloat = 0.60
    internal static let smallRatio: CGFloat = 0.225
    
    let dynamicTypeSize: DynamicTypeSize
    
    func make(
        with textStyle: Font.TextStyle,
        scaledMetrics: CGFloat
    ) -> CGFloat {
        let idealBaseHeight = textStyle.idealBaseHeight
        
        if dynamicTypeSize == .large { return idealBaseHeight }
        
        return scale(base: idealBaseHeight, scaledMetrics: scaledMetrics).rounded()
    }
}
