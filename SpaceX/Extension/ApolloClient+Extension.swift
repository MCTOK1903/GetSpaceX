//
//  ApolloClient+Extension.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation
import Apollo

extension ApolloClient {
    func fetchPublisher<Query: GraphQLQuery>(query: Query) -> ApolloPublisher<Query> {
        return ApolloPublisher(client: self,
                               query: query)
    }
}
