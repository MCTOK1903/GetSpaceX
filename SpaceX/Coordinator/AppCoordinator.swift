//
//  AppCoordinator.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import UIKit

enum Event {
    case goToDetail
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: Coordinator? { get set }
    func eventOccurred(with type: Event, item: LaunchModel)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

class AppCoordinator: Coordinator {
    
    private enum Constants {
        static let baseURL: String = "https://api.spacex.land/graphql/"
    }
    
    // MARK: Properties
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    
    // MARK: Funcs
    func start() {
        guard let url = URL(string: Constants.baseURL) else { return }
        let vc = FeedViewBuilder.build(coordinator: self, url: url)
        navigationController?.setViewControllers([vc], animated: false)
    }

    func eventOccurred(with type: Event, item: LaunchModel) {
        switch type {
        case .goToDetail:
            navigationController?.pushViewController(LaunchDetailBuilder.build(launch: item),
                                                     animated: true)
        }
    }
}
