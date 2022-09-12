//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation

struct LaunchModel: Identifiable, Hashable {
    
    var id: String?
    var name: String?
    var details: String?
    var imageURLString: String?
}

extension LaunchModel {
    static func generateLauncModel(launchs: [LaunchesQueryResponseModel]) -> [LaunchModel] {
        var launchArray: [LaunchModel] = []
        launchs.forEach { launch in
            launchArray.append(LaunchModel(
                id: "",
                name: launch.missionName,
                details: launch.details,
                imageURLString: launch.links?.missionPatch
            )) 
        }
        return launchArray
    }
}
