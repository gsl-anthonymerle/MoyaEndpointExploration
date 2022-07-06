//
//  Breed.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import Foundation

struct BreedsAPIContainer: Decodable {
    let breeds: [Breed]
    let currentPage: Int
    let lastPage: Int
    let count: Int
    let total: Int

    private enum CodingKeys: String, CodingKey {
        case breeds = "data"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case count = "per_page"
        case total
    }
}

struct Breed: Decodable, Identifiable {
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String

    var id: String { breed }
}
