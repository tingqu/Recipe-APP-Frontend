//
//  MainTabView.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 9/12/25.
//
import SwiftUI
import Foundation


struct TabIcon<Tab: Hashable>: View {
    @Binding var selection: Tab
    let me: Tab
    let filled: String
    let unfilled: String

    var body: some View {
        Image(selection == me ? filled : unfilled)
            .renderingMode(.original)
    }
}


struct MainTabView: View {
    enum Tab {
        case a
        case b
        case c
        case d
        
        var title: String {
            return switch self {
            case .a:
                "Tab A"
            case .b:
                "Tab B"
            case .c:
                "Tab C"
            case .d:
                "Tab D"
            }
        }
    }
    
    @Environment(AppRouter.self) private var appRouter
    var body: some View {
        @Bindable var appRouter = appRouter
        
        TabView(selection: $appRouter.selectedTab) {
            
            Home()
                .tag(Tab.a)
                .environment(appRouter.homeRouter)
                .tabItem {
                    TabIcon(selection: $appRouter.selectedTab,
                            me: .a,
                            filled: "home_filled",
                            unfilled: "home")
                    Text("Home")
                }
            
            Recipes()
                .tag(Tab.b)
                .environment(appRouter.recipesRouter)
                .tabItem {
                    TabIcon(selection: $appRouter.selectedTab,
                            me: .b,
                            filled: "recipes_filled",
                            unfilled: "recipes")
                    Text("Recipes")
                }
            
            Plan()
                .tag(Tab.c)
                .environment(appRouter.planRouter)
                .tabItem {
                    TabIcon(selection: $appRouter.selectedTab,
                            me: .c,
                            filled: "plan_filled",
                            unfilled: "plan")
                    Text("Plan")
                }
            
            Setting()
                .tag(Tab.d)
                .environment(appRouter.settingRouter)
                .tabItem {
                    TabIcon(selection: $appRouter.selectedTab,
                            me: .d,
                            filled: "setting_filled",
                            unfilled: "setting")
                    Text("Setting")
                }
        }
        .sheet(item: $appRouter.presentedSheet) {
            appRouter.presentedSheet = nil
        } content: { presentedSheet in
            view(for: presentedSheet)
        }
        .environment(\.presentedSheet, $appRouter.presentedSheet)
        .environment(\.currentTab, $appRouter.selectedTab)
    }
    
    @ViewBuilder private func view(for presentedSheet: PresentedSheet) -> some View {
        switch presentedSheet {
        case .viewOne:
            ViewOne()
        case .transportation(let type):
            TransportationView(type: type)
        }
    }
}


#Preview {
    MainTabView()
        .environment(AppRouter())
}
