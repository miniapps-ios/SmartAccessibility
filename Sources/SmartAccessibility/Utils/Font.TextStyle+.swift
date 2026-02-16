import SwiftUI

extension Font.TextStyle {
    var leading: CGFloat {
        switch self {
        case .largeTitle: 41
        case .title: 34
        case .title2: 28
        case .title3: 25
        case .headline, .body: 22
        case .callout: 21
        case .subheadline: 20
        case .footnote: 18
        case .caption: 16
        case .caption2: 13
        @unknown default: 22
        }
    }
}
