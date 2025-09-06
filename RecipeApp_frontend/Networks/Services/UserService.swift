//
//  UserService.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/28/25.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func getUsers(page: Int, limit: Int, search: String?, token: String) -> AnyPublisher<[User], Error>
}

class UserService: UserServiceProtocol {
    private let apiClient = URLSessionAPIClient<UserEndpoint>()

    func getUsers(page: Int, limit: Int, search: String?, token: String) -> AnyPublisher<[User], Error> {
        apiClient.request(.getUsers(page: page, limit: limit, search: search, token: token))
    }
}
