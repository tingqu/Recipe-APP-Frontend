import SwiftUI

extension Color {
    #if canImport(UIKit)
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    #elseif canImport(AppKit)
    static let systemGroupedBackground = Color(NSColor.windowBackgroundColor)
    #endif
}
