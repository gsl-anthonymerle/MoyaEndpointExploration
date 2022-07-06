//
//  BreedsViewModel.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import Foundation
import Moya
import CombineMoya
import Combine

enum BreedsAPITarget: TargetType {
    case breeds

    var baseURL: URL { URL(string: "https://catfact.ninja")! }

    var path: String { "/breeds" }

    var method: Moya.Method { .get }

    var sampleData: Data { Data() }

    var task: Task { .requestParameters(parameters: ["page": 1], encoding: URLEncoding()) }

    var headers: [String : String]? { nil }
}

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

protocol BreedsViewModelProtocol: ObservableObject {
    var breeds: [Breed] { get }

    func loadBreeds()
}

class BreedsViewModel {
    var breeds: [Breed] = [] {
        willSet {
            objectWillChange.send()
        }
    }

    let dataProvider = MoyaProvider<BreedsAPITarget>()
    private var cancellables: Set<AnyCancellable> = []
}

extension BreedsViewModel: BreedsViewModelProtocol {
    func loadBreeds() {
        dataProvider
            .requestPublisher(.breeds)
            .map(\.data)
            .decode(type: BreedsAPIContainer.self, decoder: JSONDecoder())
            .map(\.breeds)
            .catch { _ in Just([]) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.breeds = $0
            }
            .store(in: &cancellables)
    }
}
