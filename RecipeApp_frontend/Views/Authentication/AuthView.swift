//
//  AuthView.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 9/7/25.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            if viewModel.activeScreen == .LOGIN {
                VStack {
                    Spacer()
                    LoginView()
                    Spacer()
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.black.opacity(0.7))
                        Button(action: { self.changeScreen() }) {
                            Text("Sign Up")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color.accent)
                        }
                    }
                   
                }
            }
            else {
                Spacer()
                RegisterView()
                Spacer()
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color.black.opacity(0.8))
                    
                    Button(action: { self.changeScreen() }) {
                        Text("Sign In")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.accent)
                    }.padding([.leading], -2)
                }.padding([.top], 10)
            }
        }
    }

    func changeScreen() {
        viewModel.switchScreen()
    }
}

#Preview {
    AuthView()
}
