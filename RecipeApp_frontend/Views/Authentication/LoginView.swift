////
////  LoginView.swift
////  RecipeApp_frontend
////
////  Created by TingQu on 9/6/25.
////
//
//import SwiftUI
//
//struct LoginView: View {
//    @State private var email = ""
//    @StateObject private var viewModel = ViewModel()
//
//    var body: some View {
//        if !viewModel.authSuccessful {
//            VStack {
//                LogoBanner()
//                CaptionedTextField(caption: "Email", text: $viewModel.email, placeholder: "Enter email", systemImage:"lock",contentType: .emailAddress)
//
//                ViewableSecureField(
//                    caption: "Password",
//                    text:  $viewModel.password,
//                    placeholder: "*****"
//                )
//
//                SubmitButton(
//                    text: viewModel.isLoading ? "Loading..." : "Log in",
//                    submitAction: {
//                        viewModel.login()
//                    }
//                )
//                .disabled(viewModel.isLoading)
//
//                if !viewModel.errorMessage.isEmpty {
//                    Text(viewModel.errorMessage)
//                        .foregroundColor(.red)
//                }
//            }
//        }
//        else{
//            RegisterView()
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}


import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        if viewModel.authSuccessful {
            // 登录成功后的主界面（按你的工程需要换成 MainTabView）
            MainTabView()
        } else {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        LogoBanner()

                        CaptionedTextField(
                            caption: "Email",
                            text: $viewModel.email,
                            placeholder: "Enter email",
                            systemImage: "envelope",
                            contentType: .emailAddress,
                            keyboard: .emailAddress,
                            submitLabel: .next
                        )

                        ViewableSecureField(
                            caption: "Password",
                            text:  $viewModel.password,
                            placeholder: "Enter password"
                        )

                        SubmitButton(
                            text: viewModel.isLoading ? "Loading..." : "Log in",
                            submitAction: { viewModel.login() }
                        )
                        .disabled(viewModel.isLoading)

                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .padding(.top, 4)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
                    // 关键：让内容至少与屏幕等高，从而垂直居中
                    .frame(minHeight: geo.size.height, alignment: .center)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    LoginView()
        .environment(AppRouter())
}
