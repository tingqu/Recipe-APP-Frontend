import SwiftUI

//struct RegisterView: View {
//    @State var username: String = ""
//    @State var email: String = ""
//    @State var password: String = ""
//    @StateObject private var viewModel = ViewModel()
//    @Environment(AppRouter.self) private var appRouter   // <-- pull from env
//
//
//    var body: some View {
//        if viewModel.authSuccessful{
//            MainTabView()
//        }else{
//            ScrollView{
//                LogoBanner()
//                CaptionedTextField(caption: "Username", text: $viewModel.username, placeholder: "Enter username", systemImage:"lock",contentType: .username)
//                CaptionedTextField(caption: "Email", text: $viewModel.username, placeholder: "Enter email", systemImage:"envelope",contentType: .emailAddress)
//                ViewableSecureField(caption: "Password", text: $viewModel.password, placeholder: "Enter password")
//                ViewableSecureField(caption: "Confirm password", text: $viewModel.confirmedPassword, placeholder: "reenter password")
//                SubmitButton(text: "Sign Up") {
//                    viewModel.signup()
//                }
//            }
//        }
//    }
//}


struct RegisterView: View {
    @StateObject private var viewModel = ViewModel()
    @Environment(AppRouter.self) private var appRouter

    var body: some View {
        if viewModel.authSuccessful {
            MainTabView()
        } else {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        LogoBanner()

                        CaptionedTextField(
                            caption: "Username",
                            text: $viewModel.username,
                            placeholder: "Enter username",
                            systemImage: "person",
                            contentType: .username,
                            submitLabel: .next
                        )

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
                            text: $viewModel.password,
                            placeholder: "Enter password"
                        )

                        ViewableSecureField(
                            caption: "Confirm password",
                            text: $viewModel.confirmedPassword,
                            placeholder: "Re-enter password"
                        )

                        SubmitButton(text: "Sign Up") {
                            viewModel.signup()
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                    .frame(
                        minHeight: geometry.size.height,  // 占满整个屏幕高度
                        maxHeight: .infinity,
                        alignment: .center                // 垂直居中
                    )
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .scrollDismissesKeyboard(.interactively)
        }
    }
}



#Preview {
    RegisterView()
        .environment(AppRouter()) 
}
