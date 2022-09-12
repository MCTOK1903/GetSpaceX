//
//  FeedViewBuilder.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import Foundation
import Apollo
import UIKit

enum FeedViewBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        let httpClient = HttpClient(client: ApolloClient(url: URL(string: "https://api.spacex.land/graphql/")!))
        let viewModel = FeedViewModel(httpClient: httpClient,
                                      coordinator: coordinator)
        let vc = FeedViewController(viewModel: viewModel)
        
        return vc
    }
}
