//
//  FeedViewModel.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation
import Combine

enum ListViewModelError: Error, Equatable {
    case launchFetch
}

enum FeedViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(String)
}

final class FeedViewModel: Coordinating {
    
    // MARK: Constant
    private enum Constant {
        static let LastItemCountofStartPagination = 1
    }
    
    // MARK: Properties
    private let httpClient: HttpClientProtocol
    private var bindings = Set<AnyCancellable>()
    private var isPaginating = false
    var offset: Int = .zero
    @Published private(set) var launchs: [LaunchModel] = []
    @Published private(set) var state: FeedViewModelState = .loading
    
    var coordinator: Coordinator?
    
    enum Section { case launch }
    
    // MARK: Init
    init(httpClient: HttpClientProtocol,
         coordinator: Coordinator) {
        self.httpClient = httpClient
        self.coordinator = coordinator
    }
}

// MARK: - Public Func
extension FeedViewModel {
    func viewDidLoad() {
        getLaunches()
    }
    
    func getLaunches() {
        httpClient.fetch(offSet: self.offset)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .finishedLoading
                case .failure:
                    self?.state = .error(ListViewModelError.launchFetch.localizedDescription)
                }
            } receiveValue: { [weak self] launchs in
                self?.launchs += launchs
                self?.isPaginating = launchs.isEmpty
            }
            .store(in: &bindings)
    }
}

// MARK: FeedCollectionDataManagerOutput
extension FeedViewModel: FeedCollectionDataManagerOutput {
    func onDidSelect(indexPath: IndexPath) {
        coordinator?.eventOccurred(with: .goToDetail,
                                   item: self.launchs[indexPath.item])
    }
    
    func onWillDisplay(indexPath: IndexPath) {
        if indexPath.item == (launchs.count - Constant.LastItemCountofStartPagination)
            && !isPaginating {
            self.offset += launchs.count
            getLaunches()
            self.isPaginating = true
        }
    }
}
