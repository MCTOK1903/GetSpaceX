//
//  Reuseable+Extension.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import Foundation


protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
