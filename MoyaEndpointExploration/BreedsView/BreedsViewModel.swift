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
    var selectedSpecies: Species { get set }

    func loadBreeds()
}

class BreedsViewModel {
    var breeds: [Breed] = [] {
        willSet {
            objectWillChange.send()
        }
    }

    var selectedSpecies: Species = .cats {
        didSet {
            loadBreeds(forSpecies: selectedSpecies)
        }
    }

    let dataProvider = MoyaProvider<BreedsAPITarget>()
    private var cancellables: Set<AnyCancellable> = []

    private func loadBreeds(
        forSpecies species: Species
    ) {
        dataProvider
            .requestPublisher(.breeds(forSpecies: species))
            .map(\.data)
            .decodeBreeds(forSpecies: species)
            .catch { _ in Just([]) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.breeds = $0
            }
            .store(in: &cancellables)
    }
}

extension BreedsViewModel: BreedsViewModelProtocol {
    func loadBreeds() {
        loadBreeds(forSpecies: selectedSpecies)
    }
}

private extension BreedsAPITarget {
    static func breeds(
        forSpecies species: Species
    ) -> BreedsAPITarget {
        switch species {
        case .cats:
            return .catsBreeds
        case .dogs:
            return .dogsBreeds
        }
    }
}

private extension Endpoint {
    static func breeds(
        forSpecies species: Species
    ) -> Endpoint {
        switch species {
        case .cats:
            return .catsBreeds()
        case .dogs:
            return .dogsBreeds()
        }
    }
}
