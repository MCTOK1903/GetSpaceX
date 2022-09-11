//
//  HttpClient.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 9.09.2022.
//

import Foundation
import Combine
import Apollo

enum ApolloError: Error {
    case loading(description: String)
}

protocol HttpClientProtocol {
    
}

class HttpClient {
    
    let apollo: ApolloClient
    
    init(client: ApolloClient) {
        self.apollo = client
    }
    
    func fetch() -> AnyPublisher<String, Error> {
        return apollo.fetchPublisher(query: GetLaunchesQuery())
            .mapError { error in
                return error
            }
            .map { response in
               return response.data?.launches?.description ?? ""
            }
            .eraseToAnyPublisher()
    }
}



