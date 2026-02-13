import SwiftUI

public extension View {
    
    /// Scales the view frame size proportionally according to the environment's `imageScale`.
    ///
    /// Use this modifier to maintain consistent proportions between an `Image` (configured with a fixed `.font()`)
    /// and its background container (e.g., a `ZStack`, `Circle`, or `RoundedRectangle`).
    ///
    /// This is particularly useful in designs where the container must "hug" the icon
    /// with a specific ratio, ensuring the background scales in sync when the user changes
    /// the system-wide `Image.Scale` (`.small`, `.medium`, or `.large`).
    ///
    /// ### Example
    /// ```swift
    /// ZStack {
    ///     RoundedRectangle(cornerRadius: 30)
    ///         .fill(Color.pink)
    ///
    ///     Image(systemName: "person.fill")
    ///         .font(.system(size: 64))
    ///         .foregroundStyle(.background)
    /// }
    /// .scaledContainer(baseFontSize: 64)
    /// ```
    ///
    /// - Parameter baseFontSize: The fixed font size applied to the image, used as the reference point for scaling the container.
    func scaledContainer(
        baseFontSize: CGFloat
    ) -> some View {
        modifier(ScaledContainerViewModifier(baseFontSize: baseFontSize))
    }
}

struct ScaledContainerViewModifier: ViewModifier {
    @Environment(\.imageScale) private var imageScale
    
    let baseFontSize: CGFloat
    
    func body(content: Content) -> some View {
        let imageScaleRatio = ImageScaler(imageScale: imageScale).ratio
        let fontRatio = 2 * imageScaleRatio
        let w = baseFontSize * fontRatio
        
        content.frame(width: w, height: w)
    }
}
