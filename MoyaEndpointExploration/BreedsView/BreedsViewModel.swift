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
