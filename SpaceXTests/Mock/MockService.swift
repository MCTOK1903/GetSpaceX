//
//  MockService.swift
//  SpaceXTests
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import Foundation
import Combine
@testable import SpaceX

final class MockService: HttpClientProtocol {
    
    var getCallCounts = 0
    
    var result: Result<[LaunchModel], Error> = .success([])
    
    func fetch(offSet: Int) -> AnyPublisher<[LaunchModel], Error> {
        getCallCounts += 1
        
        return result.publisher.eraseToAnyPublisher()
    }
}
