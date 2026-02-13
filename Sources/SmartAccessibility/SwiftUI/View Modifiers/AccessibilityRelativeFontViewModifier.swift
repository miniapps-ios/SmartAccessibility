import SwiftUI

public extension View {
    
    /// Anchors a font to a `TextStyle` in order to make it dynamic.
    /// - Parameters:
    ///   - familyName: the name of the custom font family or empty string for system fonts.
    ///   - fontSize: the size of the font.
    ///   - fontWeight: the weight of the font.
    ///   - textStyle: the ancor system style.
    func accessibilityRelativeFont(
        familyName: String = "",
        fontSize: CGFloat,
        fontWeight: Font.Weight? = nil,
        textStyle: Font.TextStyle = .body
    ) -> some View {
        modifier(
            AccessibilityRelativeFontViewModifier(
                familyName: familyName,
                fontSize: fontSize,
                fontWeight: fontWeight,
                textStyle: textStyle
            )
        )
    }
}

struct AccessibilityRelativeFontViewModifier: ViewModifier {
    let familyName: String
    let fontSize: CGFloat
    let fontWeight: Font.Weight?
    let textStyle: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(.custom(familyName, size: fontSize, relativeTo: textStyle))
            .fontWeight(fontWeight)
    }
}
