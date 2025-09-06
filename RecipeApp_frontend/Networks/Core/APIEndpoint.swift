import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension APIEndpoint {
    func asURLRequest(jsonOptions: JSONSerialization.WritingOptions = []) throws -> URLRequest {
            let base = baseURL.appendingPathComponent(path)
            switch parameterEncoding {
            case .queryString:
                var comps = URLComponents(url: base, resolvingAgainstBaseURL: false)!
                if let params = parameters, !params.isEmpty {
                    comps.queryItems = params.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
                }
                var req = URLRequest(url: comps.url!)
                req.httpMethod = method.rawValue
                headers?.forEach { req.setValue($1, forHTTPHeaderField: $0) }
                return req

            case .jsonBody:
                var req = URLRequest(url: base)
                req.httpMethod = method.rawValue
                headers?.forEach { req.setValue($1, forHTTPHeaderField: $0) }
                if let params = parameters {
                    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    req.httpBody = try JSONSerialization.data(withJSONObject: params, options: jsonOptions)
                }
                return req
            }
    }
}
