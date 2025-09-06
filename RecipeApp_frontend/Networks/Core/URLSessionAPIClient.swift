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
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let http = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard (200...299).contains(http.statusCode) else {
                    throw APIError.httpStatus(code: http.statusCode, data: data)
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> Error in
                if let decErr = error as? DecodingError { return APIError.decoding(decErr) }
                if let apiErr = error as? APIError { return apiErr }
                return APIError.transport(error)
            }
            // Move heavy work off main if you want; deliver back on main in call site.
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .eraseToAnyPublisher()
    }
}
