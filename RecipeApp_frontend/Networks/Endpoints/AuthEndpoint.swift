import Foundation

enum AuthEndpoint: APIEndpoint {
    case signUp(username: String, email: String, password: String)
    case signIn(email: String, password: String)

    var baseURL: URL { URL(string: "http://localhost:5001/api/auth")! }

    var path: String {
        switch self {
        case .signUp: return "/signup"
        case .signIn: return "/signin"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .signUp, .signIn: return .post
        }
    }

    var headers: [String : String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    var parameters: [String : Any]? {
        switch self {
        case let .signUp(username, email, password):
            return ["username": username, "email": email, "password": password]
        case let .signIn(email, password):
            return ["email": email, "password": password]
        }
    }

    var parameterEncoding: ParameterEncoding {
        .jsonBody
    }
}
