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
    func eventOccurred(with type: Event, item: Any)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func eventOccurred(with type: Event, item: Any) {
        switch type {
        case .goToDetail:
            break
//            let vc = ItemDetailViewBuilder.build(coordinator: self,
//                                                 item: item)
//            navigationController?.pushViewController(vc,
//                                                     animated: true)
        }
    }

    func start() {
        let vc = FeedViewBuilder.build(coordinator: self)
        navigationController?.setViewControllers([vc], animated: false)
    }
}
