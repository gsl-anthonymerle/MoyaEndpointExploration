//
//  BreedsAPITarget.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import Foundation
import Moya

enum BreedsAPITarget: TargetType {
    case catsBreeds
    case dogsBreeds

    var baseURL: URL {
        switch self {
        case .catsBreeds:
            return Endpoint.catsBaseURL
        case .dogsBreeds:
            return Endpoint.dogsBaseURL
        }
    }

    var path: String {
        switch self {
        case .catsBreeds:
            return "/breeds"
        case .dogsBreeds:
            return "/breeds/list/all"
        }
    }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task {
        switch self {
        case .catsBreeds:
            return .requestParameters(
                parameters: ["page": 1],
                encoding: URLEncoding())
        case .dogsBreeds:
            return .requestPlain
        }
    }

    var headers: [String : String]? { nil }
}

extension Endpoint {
    static func catsBreeds() -> Endpoint {
        Endpoint(
            baseURL: Endpoint.catsBaseURL,
            method: .get
        )
        .extendingPath(with: "/breeds")
        .withURLParameters([
            "page": 1
        ])
    }

    static func dogsBreeds() -> Endpoint {
        Endpoint(
            baseURL: Endpoint.dogsBaseURL,
            method: .get
        )
        .extendingPath(with: "/breeds/list/all")
    }
}
