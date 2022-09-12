//
//  FeedCellViewModel.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import Foundation

struct FeedCellViewModel {
    
    private let launch: LaunchModel
    
    init(launch: LaunchModel) {
        self.launch = launch
    }
    
    var imageURl: URL? {
        return URL(string: launch.imageURLString ?? "")
    }
    
    var launchDescription: String {
        return launch.details ?? ""
    }
    
    var launcName: String {
        return launch.name ?? ""
    }
}
