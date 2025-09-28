//
//  URLSessionAPIClient.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/28/25.
//
import Combine
import Foundation

final class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
        // optional: configure decoder (e.g., dates)
        // self.decoder.dateDecodingStrategy = .iso8601
    }

    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        // Build request with parameters encoded properly
        let request: URLRequest
        do {
            request = try endpoint.asURLRequest()
        } catch {
            print("❌ asURLRequest() failed:", error)

            return Fail(error: error).eraseToAnyPublisher()
        }
        
        // Log the request
        print("🌐 \(request.httpMethod ?? "?") \(request.url?.absoluteString ?? "?")")
        if let headers = request.allHTTPHeaderFields { print("↗️ Headers:", headers) }
        if let body = request.httpBody,
           let bodyStr = String(data: body, encoding: .utf8) {
            print("↗️ Body:", bodyStr)
        }
        
        // URLSessionAPIClient.swift
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let http = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard (200...299).contains(http.statusCode) else {
                    let body = String(data: data, encoding: .utf8) ?? "<\(data.count) bytes>"
                    print("🚫 HTTP \(http.statusCode) \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
                    print("⬅️ Error body:", body)
                    throw APIError.httpStatus(code: http.statusCode, body: body)
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> Error in
                if let dec = error as? DecodingError { return APIError.decoding(dec) }
                if let url = error as? URLError { return APIError.transport(url) }
                return error
            }
            .eraseToAnyPublisher()

    }
}
