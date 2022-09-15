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

extension LaunchModel {
    static func generateMockLauncModel() -> [LaunchModel]{
        [LaunchModel(id: "13",
                    name: "Thaicom 6",
                    details: "Second GTO launch for Falcon 9. The USAF evaluated launch data from this flight as part of a separate certification program for SpaceX to qualify to fly U.S. military payloads and found that the Thaicom 6 launch had \"unacceptable fuel reserves at engine cutoff of the stage 2 second burnoff",
                    imageURLString: "https://images2.imgbox.com/37/c4/jRAk115c_o.png")]
    }
}
