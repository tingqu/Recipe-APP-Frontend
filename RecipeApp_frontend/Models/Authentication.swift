//
//  Authentication.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 9/7/25.
//

import Foundation

struct SignUpResponse: Decodable{
    let message:String
    let user: User
}

struct SignInResponse: Decodable, Identifiable {
    let id: UUID
    let username: String
    let email: String
    let accessToken: String
    let refreshToken: String
}

