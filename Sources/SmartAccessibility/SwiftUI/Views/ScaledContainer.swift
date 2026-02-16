import SwiftUI

/// A convenience container that automatically scales its background and content
/// based on the system `imageScale`.
///
/// Use `ScaledContainer` when you want to encapsulate an icon and its background
/// (like a `Shape`) ensuring they stay perfectly
/// proportional regardless of the user's accessibility settings for images.
///
/// - Parameters:
///   - baseFontSize: The baseline font size used to calculate the proportional frame.
///   - container: A closure returning the background view.
///   - content: A closure returning the foreground content (typically an `Image`).
public struct ScaledContainer<Container: View, Content: View>: View {
    let baseFontSize: CGFloat
    let container: () -> Container
    let content: () -> Content
    
    public init(
        baseFontSize: CGFloat,
        container: @escaping () -> Container,
        content: @escaping () -> Content
    ) {
        self.baseFontSize = baseFontSize
        self.container = container
        self.content = content
    }
    
    public var body: some View {
        
        ZStack {
            container()
            content()
        }
        .scaledContainer(baseFontSize: baseFontSize)
    }
}

#Preview {
    VStack(spacing: 30) {
        ScaledContainer(baseFontSize: 64) {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.pink)
                .aspectRatio(1.0, contentMode: .fill)
        } content: {
            Image(systemName: "person.fill")
                .font(.system(size: 64))
                .foregroundStyle(.background)
        }
        .environment(\.imageScale, .large)
        
        ScaledContainer(baseFontSize: 22) {
            Capsule()
                .fill(Color.pink)
        } content: {
            Text("Edit")
                .font(.system(size: 22))
                .foregroundStyle(.background)
        }
    }
}
