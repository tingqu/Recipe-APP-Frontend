import Combine
import Foundation

extension LoginView {
    @MainActor class ViewModel: ObservableObject {
        @Published var email: String = ""
        @Published var password: String = ""

        @Published var authSuccessful: Bool = false

        @Published var errorMessage: String = ""

        @Published var isLoading: Bool = false

        private var cancellables = Set<AnyCancellable>()
        private let authService: AuthServiceProtocol

        init(authService: AuthServiceProtocol = AuthService()) {
            self.authService = authService
        }

        func login() {
            guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Please enter username and password"
                return
            }

            isLoading = true
            errorMessage = ""

            authService
                .signin(email: email, password: password)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { [weak self] completion in
                        guard let self = self else { return }
                        self.isLoading = false
                        switch completion {
                        case .failure(let error):
                            self.errorMessage = error.localizedDescription
                            self.authSuccessful = false
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { [weak self] response in
                        guard let self = self else { return }
                        let token = response.accessToken
                        AuthManager.shared.saveUserData(accessToken: response.accessToken, refreshToken: response.refreshToken, id: response.id, username: response.username)
                        UserDefaults.standard.set(token, forKey: "authToken")
                        self.authSuccessful = true
                    }
                )
                .store(in: &cancellables)
        }
    }
}
