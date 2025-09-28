//
//  User.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/28/25.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: UUID
    let username: String
    let email: String
    let createdAt: Date?
    let updatedAt: Date?   

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
