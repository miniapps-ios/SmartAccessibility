import SwiftUI

struct TypographyScaler: ScaleDynamicTypeSizeProtocol {
    internal static let squareRootRatio: CGFloat = 1.0
    internal static let largeRatio: CGFloat = 0.3
    internal static let smallRatio: CGFloat = 0.225
    
    let dynamicTypeSize: DynamicTypeSize
    
    func make(with textStyle: Font.TextStyle) -> CGFloat {
        let baseLeading = textStyle.leading
        let internalPadding = (baseLeading * 0.3).rounded()
        let idealBaseHeight = baseLeading + (internalPadding * 2)
        
        if dynamicTypeSize == .large {
            return idealBaseHeight
        }
        
        return scale(base: idealBaseHeight, scaledMetrics: idealBaseHeight * 1.5).rounded()
    }
}


