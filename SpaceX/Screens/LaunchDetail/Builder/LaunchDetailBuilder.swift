//
//  LaunchDetailBuilder.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 15.09.2022.
//

import Foundation
import UIKit

enum LaunchDetailBuilder {
    static func build(launch: LaunchModel) -> UIViewController {
        let viewModel = LaunchDetailViewModel(launch: launch)
        let vc = LaunchDetailViewController(viewModel: viewModel)
        
        return vc
    }
}
