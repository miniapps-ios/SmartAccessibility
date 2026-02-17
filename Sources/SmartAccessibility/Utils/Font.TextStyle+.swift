import SwiftUI

extension Font.TextStyle {
    var leading: CGFloat {
        switch self {
        case .largeTitle: 32
        case .title: 28
        case .title2: 27
        case .title3: 26
        case .headline, .body: 24
        case .callout: 23
        case .subheadline: 22
        case .footnote: 20
        case .caption: 18
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
