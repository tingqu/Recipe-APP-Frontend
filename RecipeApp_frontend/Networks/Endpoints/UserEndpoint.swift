//
//  UserEndpoint.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/25/25.
//

import Foundation

enum UserEndpoint: APIEndpoint {
    // UI-provided values live in the associated values:
    case getUsers(page: Int, limit: Int, search: String?, token: String)

    var baseURL: URL { URL(string: "https://example.com/api")! }

    var path: String {
        switch self {
        case .getUsers: return "/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers: return .get
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getUsers(_, _, _, let token):
            return ["Authorization": "Bearer \(token)", "Accept": "application/json"]
        }
    }

    // <- parameters remain on the endpoint
    var parameters: [String : Any]? {
        switch self {
        case .getUsers(let page, let limit, let search, _):
            var dict: [String: Any] = ["page": page, "limit": limit]
            if let s = search, !s.isEmpty { dict["search"] = s }
            return dict
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getUsers: return .queryString
        }
    }
}
