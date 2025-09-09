//
//  LoginView.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 9/6/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        if !viewModel.authSuccessful {
            VStack {
                LogoBanner()
                CaptionedTextField(
                    caption: "Email",
                    text: $viewModel.email,
                    placeholder: "Enter email",
                    imageName: "email"
                )

                ViewableSecureField(
                    caption: "Password",
                    text:  $viewModel.password,
                    placeholder: "*****"
                )

                SubmitButton(
                    text: viewModel.isLoading ? "Loading..." : "Log in",
                    submitAction: {
                        viewModel.login()
                    }
                )
                .disabled(viewModel.isLoading)

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
            }
        }
        else{
            RegisterView()
        }
    }
}

#Preview {
    LoginView()
}
