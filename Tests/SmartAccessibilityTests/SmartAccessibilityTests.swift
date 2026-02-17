import Testing
import SwiftUI
@testable import SmartAccessibility

struct ScaledMetricSizeTests {

    let baseSize = CGSize(width: 100, height: 100)

    @Test("Validate scaling Standard (.small / .medium / .large)")
    func testStandardScaling() {
        let calculator = ScaledMetricsSize(baseSize: baseSize, dynamicTypeSize: .large)
        
        let result = calculator.make(scaledMetricsWidth: 100, scaledMetricsHeight: 100)
        
        #expect(result.width == 100)
        #expect(result.height == 100)
    }

    @Test("Validate scaling Large (> .large)")
    func testLargeScaling() {
        let calculator = ScaledMetricsSize(baseSize: baseSize, dynamicTypeSize: .xxxLarge)
        
        let result = calculator.make(scaledMetricsWidth: 150, scaledMetricsHeight: 150)
        
        // 100 + (50 * 0.3) = 115.0
        #expect(result.width == 115.0)
    }

    @Test("Validate scaling Accessibility (square root)")
    func testAccessibilityScaling() {
        let calculator = ScaledMetricsSize(baseSize: baseSize, dynamicTypeSize: .accessibility1)
        
        let result = calculator.make(scaledMetricsWidth: 200, scaledMetricsHeight: 200)
        
        // 100 + sqrt(100) = 110.0
        #expect(result.width == 110.0)
    }
    
    @Test("Validate negative values protection - extreme test")
    func testNegativeSafety() {
        let calculator = ScaledMetricsSize(baseSize: baseSize, dynamicTypeSize: .accessibility1)
        
        // Corrupted scale metrics
        let result = calculator.make(scaledMetricsWidth: 80, scaledMetricsHeight: 80)
        
        // max(0, extra) -> base
        #expect(result.width == 100.0)
    }
    
    @Test("Validate scaling rectangle")
    func testAsymmetricScaling() {
        let baseRect = CGSize(width: 100, height: 50)
        let calculator = ScaledMetricsSize(baseSize: baseRect, dynamicTypeSize: .xxxLarge)
        
        // Scaling 50% (1.5x)
        // Width target: 150, Height target: 75
        let result = calculator.make(scaledMetricsWidth: 150, scaledMetricsHeight: 75)
        
        // Width: 100 + (50 * 0.3) = 115
        // Height: 50 + (25 * 0.3) = 57.5
        #expect(result.width == 115.0)
        #expect(result.height == 57.5)
    }
    
    @Test("Validate TypographyScaler")
    func testTyporaphyScaler() {
        let scaler: TypographyScaler = .init(dynamicTypeSize: .accessibility5)
        let scaledHeight: CGFloat = scaler.make(with: .title2, scaledMetrics: 141)
        print("scaled height \(scaledHeight)")
        #expect(scaledHeight != 600.0)
    }
}
