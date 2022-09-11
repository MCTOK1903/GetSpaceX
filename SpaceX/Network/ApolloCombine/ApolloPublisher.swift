//
//  ApolloPublisher.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation
import Apollo
import Combine

struct ApolloPublisher<Query: GraphQLQuery>: Publisher {
    
    typealias Output = GraphQLResult<Query.Data>
    typealias Failure = Error
    
    private let client: ApolloClient
    private let query: Query
    
    init(client:ApolloClient,
         query: Query) {
        self.client = client
        self.query = query
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Error, S.Input == GraphQLResult<Query.Data> {
        let subscription = ApolloSubscription(client: self.client,
                                                    query: self.query,
                                                    subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}
