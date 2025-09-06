import Foundation
import Combine

class UsersViewModel: ObservableObject {
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    /// Call this from the View (token from Keychain/env)
    func fetchUsers(page: Int = 1, limit: Int = 20, search: String? = nil, token: String) {
        errorMessage = nil
        isLoading = true

        userService.getUsers(page: page, limit: limit, search: search, token: token)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
