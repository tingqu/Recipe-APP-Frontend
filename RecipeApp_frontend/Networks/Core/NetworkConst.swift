import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// APIError.swift
enum APIError: Error, LocalizedError {
    case invalidResponse
    case httpStatus(code: Int, body: String)
    case decoding(DecodingError)
    case transport(URLError)

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response."
        case .httpStatus(let code, let body): return "HTTP \(code): \(body)"
        case .decoding(let e): return "Decoding error: \(e)"
        case .transport(let e): return "Network error: \(e.localizedDescription)"
        }
    }
}

enum ParameterEncoding { case queryString, jsonBody }
