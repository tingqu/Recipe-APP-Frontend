//
//  RecipeApp_frontendApp.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/24/25.
//

import SwiftUI
import Foundation

@main
struct RecipeApp_frontendApp: App {
    @State private var appRouter = AppRouter()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appRouter)

        }
    }
}

