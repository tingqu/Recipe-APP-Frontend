//////
//////  RegisterViewModel.swift
//////  RecipeApp_frontend
//////
//////  Created by TingQu on 9/9/25.
//////
//
//import Combine
//import Foundation
//
//extension RegisterView {
//    @MainActor class ViewModel: ObservableObject {
//        @Published var username: String = ""
//        @Published var email: String = ""
//        @Published var password: String = ""
//        @Published var confirmedPassword: String = ""
//
//        @Published var isLoading: Bool = false
//        @Published var errorMessage: String = ""
//        @Published var authSuccessful: Bool = false
//
//        private var cancellables = Set<AnyCancellable>()
//        private let authService: AuthServiceProtocol
//
//        init(authService: AuthServiceProtocol = AuthService()) {
//            self.authService = authService
//        }
//
//        func signup() {
//            guard !email.isEmpty, !password.isEmpty, !username.isEmpty,
//                !confirmedPassword.isEmpty
//            else {
//                errorMessage = "Please enter correct information"
//                return
//            }
//
//            let validator = InputValidator()
//
//            if validator.validateUsername(username: username) == false {
//                errorMessage =
//                    "Invalid username. Username must be at least 6 characters and can only contain alphanumeric characters and at least one alphabet character"
//                return
//            }
//
//            if validator.validatePassword(password: password) == false {
//                errorMessage =
//                    "Invalid password. Password must be at least 6 characters. Only symbols allowed: !,@,#,$,%,^,&,*,(,),{,},<,>,.,;"
//            }
//
//            authService
//                .signup(usename: username, email: email, password: password)
//                .receive(on: DispatchQueue.main)
//                .sink(
//                    receiveCompletion: { [weak self] completion in
//                        guard let self = self else { return }
//                        if case .failure(let error) = completion {
//                            self.isLoading = false
//                            self.errorMessage = error.localizedDescription
//                            self.authSuccessful = false
//                        }
//                    },
//                    receiveValue: { [weak self] _ in
//                        guard let self = self else { return }
//                        self.signinAfterSignup()
//                    }
//                )
//                .store(in: &cancellables)
//        }
//
//        private func signinAfterSignup() {
//            authService
//                .signin(email: email, password: password)
//                .receive(on: DispatchQueue.main)
//                .sink(
//                    receiveCompletion: { [weak self] completion in
//                        guard let self = self else { return }
//                        self.isLoading = false
//                        if case .failure(let error) = completion {
//                            self.errorMessage =
//                                "Signed up, but login failed: \(error.localizedDescription)"
//                            self.authSuccessful = false
//                        }
//                    },
//                    receiveValue: { [weak self] signInResponse in
//                        guard let self = self else { return }
//                        // 3️⃣ Save to AuthManager.shared
//                        AuthManager.shared.saveUserData(
//                            accessToken: signInResponse.accessToken,
//                            refreshToken: signInResponse.refreshToken,
//                            id: signInResponse.id,
//                            username: signInResponse.username
//                        )
//                        self.authSuccessful = true
//                    }
//                )
//                .store(in: &cancellables)
//        }
//    }
//}


import Combine
import Foundation

extension RegisterView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var username = ""
        @Published var email = ""
        @Published var password = ""
        @Published var confirmedPassword = ""

        @Published var isLoading = false
        @Published var errorMessage = ""
        @Published var authSuccessful = false

        private var cancellables = Set<AnyCancellable>()
        private let authService: AuthServiceProtocol

        init(authService: AuthServiceProtocol = AuthService()) {
            self.authService = authService
        }

        func signup() {
            print("🧪 signup() called")

            // Validate
            guard !username.isEmpty, !email.isEmpty, !password.isEmpty, !confirmedPassword.isEmpty else {
                errorMessage = "Please fill in all fields."
                print("🛑 validation: empty fields")
                return
            }
            guard password == confirmedPassword else {
                errorMessage = "Passwords do not match."
                print("🛑 validation: mismatch")
                return
            }
            let validator = InputValidator()
            guard validator.validateUsername(username: username) else {
                errorMessage = "Invalid username."
                print("🛑 validation: username")
                return
            }
            guard validator.validatePassword(password: password) else {
                errorMessage = "Invalid password."
                print("🛑 validation: password")
                return
            }

            isLoading = true
            errorMessage = ""
            print("➡️ calling signup API for \(email)")

            authService
                .signup(usename: username, email: email, password: password)
                .flatMap { [unowned self] (
                    _: SignUpResponse
                ) -> AnyPublisher<SignInResponse, Error> in
                    print("✅ signup succeeded → calling signin")
                    return self.authService
                        .signin(email: self.email, password: self.password)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self else { return }
                    self.isLoading = false
                    if case .failure(let err) = completion {
                        print("🚫 chain failed:", err)

                        // Prefer a message from server body if we have one
                        if case let APIError.httpStatus(_, body) = err,
                           let message = Self.extractMessage(from: body) {
                            self.errorMessage = message
                        } else {
                            self.errorMessage = (
                                err as? LocalizedError
                            )?.errorDescription ?? err.localizedDescription
                        }
                        self.authSuccessful = false
                    } else {
                        print("ℹ️ chain finished")
                    }
                } receiveValue: { [weak self] signIn in
                    guard let self else { return }
                    print("🎉 signin OK → saving session")
                    AuthManager.shared.saveUserData(
                        accessToken: signIn.accessToken,
                        refreshToken: signIn.refreshToken,
                        id: signIn.id,                // AuthManager.id is String
                        username: signIn.username
                    )
                    self.authSuccessful = true
                }
                .store(in: &cancellables)
        }
        
        private static func extractMessage(from body: String) -> String? {
            struct Err: Decodable {
                let message: String?; let error: String?; let errors: [String]?
            }
            guard let data = body.data(using: .utf8) else { return nil }
            if let payload = try? JSONDecoder().decode(Err.self, from: data) {
                return payload.message ?? payload.error ?? payload.errors?
                    .joined(separator: ", ")
            }
            // Fallback: sometimes servers return plain text
            return body.isEmpty ? nil : body
        }
    }
}
