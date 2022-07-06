//
//  BreedItemView.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import SwiftUI

struct BreedItemView: View {
    let breed: Breed

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(breed.breed)
                .font(.headline)

            VStack(alignment: .leading) {
                HStack {
                    Text(breed.coat)
                    Text("-")
                    Text(breed.pattern)
                }
                Text(breed.country)
            }
            .foregroundColor(.gray)
        }
    }
}

struct BreedItemView_Previews: PreviewProvider {
    static var previews: some View {
        BreedItemView(breed: Breed(
            breed: "German Sherpherd",
            country: "Germany",
            origin: "Germany",
            coat: "Black and sand",
            pattern: "Bicolor"))
    }
}
