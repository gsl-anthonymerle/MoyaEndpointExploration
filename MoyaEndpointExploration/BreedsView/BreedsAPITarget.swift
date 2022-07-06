//
//  BreedsAPITarget.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import Foundation
import Moya

enum BreedsAPITarget: TargetType {
    case breeds

    var baseURL: URL { URL(string: "https://catfact.ninja")! }

    var path: String { "/breeds" }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters: ["page": 1], encoding: URLEncoding()) }

    var headers: [String : String]? { nil }
}
