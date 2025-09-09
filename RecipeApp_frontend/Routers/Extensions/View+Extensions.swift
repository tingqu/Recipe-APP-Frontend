import SwiftUI

extension View {
    func navigationBackButton(title: String? = nil,
                              action: @escaping () -> Void) -> some View {
        // Choose correct placement per platform
        let placement: ToolbarItemPlacement = {
            #if os(iOS) || os(tvOS)
            return .navigationBarLeading
            #elseif os(macOS)
            return .navigation
            #else
            return .automatic
            #endif
        }()

        // Base back button UI
        let backButton = Button(action: action) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.backward")
                    .fontWeight(.semibold)
                if let title {
                    Text(title)
                        .foregroundStyle(Color.accentColor)
                }
            }
        }

        return self
            #if os(iOS) || os(tvOS)
            .navigationBarBackButtonHidden(true)
            #endif
            .toolbar {
                ToolbarItem(placement: placement) {
                    backButton
                        // If these are custom extensions/constants, keep them iOS-only.
                        #if os(iOS) || os(tvOS)
                        .frame(minWidth: .navigationBarHeight)
                        .offset(x: .navigationBackButtonXOffset)
                        #endif
                }
            }
    }

    func routerDestination<D, C>(router: BaseRouter,
                                 navigationBackTitle: String? = nil,
                                 @ViewBuilder destination: @escaping (D) -> C) -> some View
    where D: Hashable, C: View {
        navigationDestination(for: D.self) { item in
            destination(item)
                .navigationBackButton(title: navigationBackTitle,
                                      action: router.navigateBack)
        }
    }
}
