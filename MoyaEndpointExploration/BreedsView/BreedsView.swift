//
//  ContentView.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import SwiftUI

struct BreedsView<ViewModel>: View where ViewModel: BreedsViewModelProtocol {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.breeds) { breed in
                    BreedItemView(breed: breed)
                        .padding(.vertical, 10)
                }
            }
            .navigationTitle("Cats breeds!")
        }
        .onAppear {
            viewModel.loadBreeds()
        }
    }
}

struct BreedsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsView(viewModel: BreedsPreviewViewModel())
    }
}

class BreedsPreviewViewModel: BreedsViewModelProtocol {
    var breeds: [Breed] = [
        Breed(
            breed: "German Sherpherd",
            country: "Germany",
            origin: "Germany",
            coat: "Black and sand",
            pattern: "Bicolor"),
        Breed(
            breed: "Siamois",
            country: "France",
            origin: "France",
            coat: "Grey",
            pattern: "Monochrome")
    ]

    func loadBreeds() {}
}
