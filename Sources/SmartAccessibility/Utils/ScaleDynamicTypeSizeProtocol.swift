import SwiftUI

protocol ScaleDynamicTypeSizeProtocol {
    
    static var squareRootRatio: CGFloat { get }
    
    static var largeRatio: CGFloat { get }
    
    static var smallRatio: CGFloat { get }
    
    var dynamicTypeSize: DynamicTypeSize { get }
    
    func getStrategy() -> ScaleStrategy
    
    func scale(base: CGFloat, scaledMetrics: CGFloat) -> CGFloat
}

extension ScaleDynamicTypeSizeProtocol {
    
    func getStrategy() -> ScaleStrategy {
        if dynamicTypeSize.isAccessibilitySize {
            .squareRoot(ratio: Self.squareRootRatio)
        } else if dynamicTypeSize > .large {
            .proportional(ratio: Self.largeRatio)
        } else {
            .proportional(ratio: Self.smallRatio)
        }
    }
    
    func scale(base: CGFloat, scaledMetrics: CGFloat) -> CGFloat {
        let strategy = getStrategy()
        switch strategy {
        case .squareRoot(let ratio):
            let extra = max(0, scaledMetrics - base)
            return base + (sqrt(extra) * ratio)
        case .proportional(let ratio):
            return base + ((scaledMetrics - base) * ratio)
        }
    }
}
