//
//  URLSessionHTTPClient.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import Foundation
import Combine

protocol HTTPClient {
    func request<T: Codable>(urlString: String, query: [URLQueryItem]) -> AnyPublisher<T, Error>
}

class URLSessionHTTPClient: HTTPClient {
    func request<T: Codable>(urlString: String, query: [URLQueryItem]) -> AnyPublisher<T, Error> {
        var components = URLComponents(string: urlString)!
        components.queryItems = query

        let url = components.url!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
