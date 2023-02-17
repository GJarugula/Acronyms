//
//  AcronymResponse.swift
//  Acronyms
//
//  Created by Gayathri Jarugula on 2/17/23.
//

import Foundation

struct AcronymResponse: Codable, Hashable {
    var shortform: String?
    var longforms: [LongForm]?

    enum CodingKeys: String, CodingKey {
        case shortform = "sf"
        case longforms = "lfs"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        shortform = try container.decodeIfPresent(String.self, forKey: .shortform)
        longforms = try container.decodeIfPresent([LongForm].self, forKey: .longforms)
    }
}

struct LongForm: Codable, Hashable {
    var longform: String?
    var frequency: Int?
    var since: Int?

    enum CodingKeys: String, CodingKey {
        case longform = "lf"
        case frequency = "freq"
        case since = "since"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        longform = try container.decodeIfPresent(String.self, forKey: .longform)
        frequency = try container.decodeIfPresent(Int.self, forKey: .frequency)
        since = try container.decodeIfPresent(Int.self, forKey: .since)
    }
}
