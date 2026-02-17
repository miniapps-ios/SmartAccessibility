import SwiftUI

extension Font.TextStyle {
    var leading: CGFloat {
        switch self {
        case .largeTitle: 38
        case .title: 36
        case .title2: 30
        case .title3: 28
        case .headline, .body: 26
        case .callout: 24
        case .subheadline: 22
        case .footnote: 20
        case .caption: 18
        case .caption2: 16
        @unknown default: 22
        }
    }
    
    var idealBaseHeight: CGFloat {
        let baseLeading = leading
        let internalPadding = (baseLeading / 2)
        return baseLeading + (internalPadding * 2).rounded()
    }
}
