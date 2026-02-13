# SmartAccessibility 🚹 🚺 ♿️

**SmartAccessibility** is a lightweight SwiftUI toolkit designed to tame complex layouts when Dynamic Type reaches accessibility sizes. Instead of simply capping font growth, it provides tools to manage space harmoniously, fluently, and intelligently.

## The Problem
When users activate accessibility sizes (from `.accessibility1` to `.accessibility5`), standard layouts often suffer an "aesthetic collapse":

* **UI Explosion:** Buttons and icons expand too much.
* **Content Occlusion:** Custom toolbars and footers obscure primary content like maps, charts, or images.
* **Linear Scaling Issues:** White space (padding) is fixed, breaking design patterns.

**SmartAccessibility** solves these issues by introducing **Damped Growth** and **Contextual Constraints**.

---

## Key Features

### 1. Limited Dynamic Type Size
Sets a "ceiling" for font growth for a specific component. If the system exceeds this limit, the **iOS Large Content Viewer** is automatically enabled, allowing users to read the content via HUD-style long-press while keeping the layout intact.

Control behaviour of accessibility settings and properly define accessibility limitation.
#### Environment Value
```swift
// The defaultValue is .accessibility1
public struct AccessibilityLimitedDynamicTypeSizeEnvironmentKey: EnvironmentKey {
    public static let defaultValue: DynamicTypeSize = .accessibility1
}

// Access the environment value
public extension EnvironmentValues {
    var accessibilityLimitedDynamicTypeSize: DynamicTypeSize {
        get { self[AccessibilityLimitedDynamicTypeSizeEnvironmentKey.self] }
        set { self[AccessibilityLimitedDynamicTypeSizeEnvironmentKey.self] = newValue }
    }
}
```
Examples:
```swift
// Global limit in your App or RootView
ContentView()
    .environment(\.accessibilityLimitedDynamicTypeSize, .accessibility3)

// Set a restriction to a View
Button(action: action, label: label)
    .accessibilityLimitedDynamicTypeSize(constrained: .xxxLarge)
```

Practical Example: MapView with Footer
In a map-centric view, it is vital that controls do not obscure the map area on smaller devices.
```swift
import SmartAccessibility

struct MapExplorer: View {

    @ViewBuilder
    private func footer() -> some View {
         Text("Hello, world!")
             .padding()
             .accessibilityLimitedDynamicTypeSize(constrained: .xxLarge)
    }

    var body: some View {
        MapView()
             .overlay(alignment: .bottom, content: footer)
    }
}
```
**Note:** be careful to handle propagation to `sheet`, `fullScreenCover` and other detached view hierarchies.
### 2. Smart Scaled Metric and Scaled Image
```swift
// Scale the frame of the View according to @ScaleMetric and @Environment(\.dynamicTypeSize)
SomeView()
    .scaledMetricSize(size: .init(width: 28, height: 28), relativeTo: .body)


// Scales the view frame size to a relative size according to \.imageScale
ZStack {
    RoundedRectangle(cornerRadius: 16)
        .aspectRatio(1.0, contentMode: .fill)

    Image(systemName: "crown.fill")
        .font(.system(size: 22))
}
.scaledImageContainer(baseFontSize: 22)
```
### 3. Damped Padding
Applies "intelligent" padding that scales using a square-root function. This allows the UI to breathe without letting margins become disproportionate at high AX sizes.
```swift
// Provides a non linear computed padding according to @ScaleMetrics and @Environment(\.dynamicTypeSize)
VStack {
    Text("Adaptive Content")
}
.accessibilityDampedPadding(16) 
// At .large: 16pt | At .accessibility5: ~28pt (instead of 50+pt)
```
### 4. Dynamic Font anchor
A super easy way to a fixed font size based to an accessibility aware based font view
```swift
// Anchor fonts with a fixed size to a system text style, to make them dynamically float.
SomeView()
    .accessibilityRelativeFont(familyName: "Avenir-Roman", fontSize: 22, textStyle: .body)
```
## Installation
In Xcode, go to File -> Add Packages...

Enter the repository URL: `https://github.com/miniapps-ios/SmartAccessibility.git`

Select Up to Next Major Version.

Requirements
iOS 26.0+

Swift 6.2+

Xcode 26+

Built with ❤️ to make adaptive interfaces truly usable for everyone.
