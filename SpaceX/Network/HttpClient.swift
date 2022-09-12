//
//  HttpClient.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 9.09.2022.
//

import Foundation
import Combine
import Apollo

typealias LaunchesQueryResponseModel = GetLaunchesQuery.Data.Launch

protocol HttpClientProtocol {
    func fetch(offSet: Int) -> AnyPublisher<[LaunchModel], Error>
}

class HttpClient: HttpClientProtocol {
    
    // MARK: Properties
    private let apollo: ApolloClient
    
    // MARK: Init
    init(client: ApolloClient) {
        self.apollo = client
    }
    
    func fetch(offSet: Int) -> AnyPublisher<[LaunchModel], Error> {
        return apollo.fetchPublisher(query: GetLaunchesQuery(offset: offSet,
                                                             limit: 20))
        .mapError { error in
            return error
        }
        .map { response in
            return LaunchModel.generateLauncModel(launchs: response.data?.launches?.compactMap({$0}) ?? [])
        }
        .eraseToAnyPublisher()
    }
}
