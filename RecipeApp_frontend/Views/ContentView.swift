//
//  ContentView.swift
//  RoutersDemo
//
//  Created by Itay Amzaleg on 10/03/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Views
    var body: some View {
        if AuthManager.shared.accessToken == ""{
            AuthView()
        }else{
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
        .environment(AppRouter())
}
