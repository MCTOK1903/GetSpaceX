//
//  ApolloSubscription.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation
import Apollo
import Combine

final class ApolloSubscription<GraphQuery: GraphQLQuery, SubscriberType: Subscriber>: Subscription where SubscriberType.Input == GraphQLResult<GraphQuery.Data>, SubscriberType.Failure == Error {
    
    private let subscriber: SubscriberType
    private var cancelable: Apollo.Cancellable?
    
    init(client: ApolloClient,
         query: GraphQuery,
         subscriber: SubscriberType) {
        self.subscriber = subscriber
        self.cancelable = client.fetch(query: query,
                                       resultHandler: self.handle)
    }
    
    deinit {
        cancelable?.cancel()
    }
    
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() {
        cancelable?.cancel()
        cancelable = nil
    }
    
    func handle(result: Result<GraphQLResult<GraphQuery.Data>, Error>) {
        switch result {
        case .success(let resultSet):
            _ = subscriber.receive(resultSet)
        case .failure(let error):
            subscriber.receive(completion: .failure(error))
        }
        subscriber.receive(completion: .finished)
    }
}
