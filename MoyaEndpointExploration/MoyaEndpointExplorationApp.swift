//
//  MoyaEndpointExplorationApp.swift
//  MoyaEndpointExploration
//
//  Created by Anthony MERLE on 06/07/2022.
//

import SwiftUI

@main
struct MoyaEndpointExplorationApp: App {
    var body: some Scene {
        WindowGroup {
            BreedsView(viewModel: BreedsViewModel())
        }
    }
}
