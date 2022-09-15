//
//  LaunchDetailViewModel.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 15.09.2022.
//

import Foundation

struct LaunchDetailViewModel {
    
    // MARK: Properties
    private let launch: LaunchModel
    
    // MARK: Init
    init(launch: LaunchModel) {
        self.launch = launch
    }
    
    var launchName: String {
        launch.name ?? ""
    }
    
    var launchImageURL: URL? {
        URL(string: launch.imageURLString ?? "")
    }
    
    var launchDescription: String {
        launch.details ?? ""
    }
}
