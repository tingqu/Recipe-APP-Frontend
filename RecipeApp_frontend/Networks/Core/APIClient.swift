//
//  APIClient.swift
//  RecipeApp_frontend
//
//  Created by TingQu on 8/28/25.
//
import Combine

protocol APIClient {
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}
