import SwiftUI

extension Font.TextStyle {
    var leading: CGFloat {
        switch self {
        case .largeTitle: 32
        case .title: 25
        case .title2: 24
        case .title3: 23
        case .headline, .body: 22
        case .callout: 21
        case .subheadline: 20
        case .footnote: 18
        case .caption: 16
        case .caption2: 14
        @unknown default: 22
        }
    }
    
    var idealBaseHeight: CGFloat {
        let baseLeading = leading
        let internalPadding = (baseLeading / 2)
        return baseLeading + (internalPadding * 2).rounded()
    }
}
