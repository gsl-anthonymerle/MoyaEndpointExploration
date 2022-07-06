//
//  Publisher+DecodeBreeds.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import Foundation
import Combine

extension Publisher where Self.Output == Data {
    func decodeBreeds(
        forSpecies species: Species
    ) -> AnyPublisher<[Breed], Error> {
        switch species {
        case .cats:
            return decodeCatBreeds()
        case .dogs:
            return decodeDogBreeds()
        }
    }

    private func decodeCatBreeds() -> AnyPublisher<[Breed], Error> {
        decode(
           type: BreedsAPIContainer.self,
           decoder: JSONDecoder())
           .map(\.breeds)
           .eraseToAnyPublisher()
    }

    private func decodeDogBreeds() -> AnyPublisher<[Breed], Error> {
        tryMap { data -> [String: [String]] in
            guard
                let responseJSON = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                let breeds = responseJSON["message"] as? [String: [String]]
            else {
                return [:]
            }
            return breeds
        }
        .map { breeds in
            breeds.map { (key, values) -> [String] in
                if values.isEmpty {
                    return [key]
                } else {
                    return values.map { "\(key) \($0)" }
                }
            }
            .flatMap { $0 }
        }
        .map { breedsNames in
            breedsNames.map {
                Breed(
                    breed: $0,
                    country: "N/A",
                    origin: "N/A",
                    coat: "N/A",
                    pattern: "N/A")
            }
        }
        .eraseToAnyPublisher()
    }
}

