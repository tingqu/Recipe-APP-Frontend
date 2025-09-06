enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
    case httpStatus(code: Int, data: Data)
    case decoding(DecodingError)
    case transport(Error)
}

enum ParameterEncoding { case queryString, jsonBody }
