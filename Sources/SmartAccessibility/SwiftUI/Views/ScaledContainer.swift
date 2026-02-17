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
    ScrollView {
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
            
            Text("Edit")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.background)
                .scaledHeightContainer(baseFontSize: 22)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Large Title")
                .font(.largeTitle.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .largeTitle)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Title")
                .font(.title.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .title)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Title2")
                .font(.title2.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .title2)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Title3")
                .font(.title3.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .title3)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Body")
                .font(.body.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .body)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Headline")
                .font(.headline.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .headline)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Callout")
                .font(.callout.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .callout)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Subheadline")
                .font(.subheadline.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .subheadline)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Footnote")
                .font(.footnote.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .footnote)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Caption")
                .font(.caption.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .caption)
                .background {
                    Capsule().fill(Color.pink)
                }
            
            Text("Caption2")
                .font(.caption2.bold())
                .foregroundStyle(.background)
                .smartHeightContainer(textStyle: .caption2)
                .background {
                    Capsule().fill(Color.pink)
                }
        }
        .frame(maxWidth: .infinity)
    }
    .scrollIndicators(.hidden)
    .environment(\.dynamicTypeSize, .large)
}
