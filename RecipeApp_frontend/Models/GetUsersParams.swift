//
//  GetUsersParams.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/28/25.
//

struct GetUsersParams: Encodable {
    var page: Int
    var limit: Int
    var search: String?
}

