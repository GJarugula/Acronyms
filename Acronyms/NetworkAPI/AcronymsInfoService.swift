//
//  AcronymsInfoService.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import Foundation
import Combine

protocol AcronymsInfoService {
    func getLongform(for acronym: String) -> AnyPublisher<[LongForm], Error>
}

class AcronymLongformService: AcronymsInfoService {
    let client: HTTPClient

    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }

    func getLongform(for acronym: String) -> AnyPublisher<[LongForm], Error> {
        let query = [URLQueryItem(name: "sf", value: acronym)]
        return client.request(urlString: "http://www.nactem.ac.uk/software/acromine/dictionary.py", query: query)
            .map { AcronymLongformService.mapping(from: $0) }
            .eraseToAnyPublisher()
    }

    private static func mapping(from result: [AcronymResponse]) -> [LongForm] {
        return result.first?.longforms ?? []
    }
}
