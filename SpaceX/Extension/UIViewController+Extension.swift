//
//  UIViewController+Extension.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
