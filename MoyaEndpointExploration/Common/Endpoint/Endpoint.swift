//
//  Endpoint.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import Foundation
import Moya

struct Endpoint: TargetType {
    let path: String

    // MARK: TargetType
    let baseURL: URL
    let method: Moya.Method
    let task: Task
    let headers: [String : String]?

    init(
        baseURL: URL,
        method: Moya.Method
    ) {
        self.init(
            path: "",
            baseURL: baseURL,
            method: method,
            task: .requestPlain,
            headers: nil)
    }

    private init(
        path: String,
        baseURL: URL,
        method: Moya.Method,
        task: Task,
        headers: [String : String]?
    ) {
        self.path = path
        self.baseURL = baseURL
        self.method = method
        self.task = task
        self.headers = headers
    }
}

extension Endpoint {
    func extendingPath(
        with path: String
    ) -> Endpoint {
        Endpoint(
            path: self.path + path,
            baseURL: baseURL,
            method: method,
            task: task,
            headers: headers)
    }

    func withURLParameters(
        _ parameters: [String: Any]
    ) -> Endpoint {
        Endpoint(
            path: path,
            baseURL: baseURL,
            method: method,
            task: .requestParameters(
                parameters: parameters,
                encoding: URLEncoding()),
            headers: headers)
    }
}

extension Endpoint {
    static var catsBaseURL: URL {
        URL(string: "https://catfact.ninja")!
    }

    static var dogsBaseURL: URL {
        URL(string: "https://dog.ceo/api")!
    }
}
