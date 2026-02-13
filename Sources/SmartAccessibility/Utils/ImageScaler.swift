import SwiftUI

struct ImageScaler {
    let ratio: CGFloat
    
    init(imageScale: Image.Scale) {
        ratio = switch imageScale {
        case .small: 0.82
        case .medium: 1.0
        case .large: 1.18
        @unknown default: 1.0
        }
    }
}
