//
//  MockCoordinator.swift
//  SpaceXTests
//
//  Created by Muhammed Celal Tok on 15.09.2022.
//

import Foundation
import UIKit
@testable import SpaceX

class MockCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var parentCoordinator: Coordinator?
    var isStart = false
    var isDetailOcuorred = false
    
    func eventOccurred(with type: Event, item: LaunchModel) {
        switch type {
        case .goToDetail:
            self.isDetailOcuorred = true
        }
    }
    
    func start() {
        self.isStart = true
    }
}
