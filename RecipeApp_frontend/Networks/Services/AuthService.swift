//
//  AuthService.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 9/7/25.
//

import Foundation
import Combine
import Observation


protocol AuthServiceProtocol {
    func signin(email: String, password: String) -> AnyPublisher<SignInResponse, Error>
    func signup(usename: String, email:String, password: String) -> AnyPublisher<SignUpResponse, Error>
}


class AuthService: AuthServiceProtocol,ObservableObject{
    private let apiClient = URLSessionAPIClient<AuthEndpoint>()
    @Published var authManager:AuthManager?
    
    func signin(email: String, password: String) -> AnyPublisher<SignInResponse, Error> {
        print("➡️ signin for \(email)")
        return apiClient.request(.signIn(email: email, password: password))
            .handleEvents(receiveOutput: { (resp: SignInResponse) in
                print("✅ response: \(resp)")
            })
            .eraseToAnyPublisher()
    }
    
    func signup(usename: String, email: String, password: String) -> AnyPublisher<SignUpResponse, Error> {
        print("➡️ signup for \(email)")
        return apiClient.request(.signUp(username: usename, email: email, password: password))
            .handleEvents(
                receiveSubscription: { _ in print("📡 signup started") },
                receiveOutput: { (resp: SignUpResponse) in print("✅ signup response: \(resp)") },
                receiveCompletion: { completion in print("ℹ️ signup completion: \(completion)") },
                receiveCancel: { print("❌ signup cancelled") }
            )
            .eraseToAnyPublisher()
    }
}

@Observable
class AuthManager: ObservableObject {
    var accessToken: String = ""
    var refreshToken: String = ""
    var id: UUID = UUID()
    var username: String = ""
    
    static let shared = AuthManager()
    
    private init() {}
    
    func saveUserData(accessToken: String, refreshToken: String, id: UUID, username: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.id = id
        self.username = username
    }
    
    func resetUserData() {
        self.accessToken = ""
        self.refreshToken = ""
        self.id = UUID()
        self.username = ""
    }
}
