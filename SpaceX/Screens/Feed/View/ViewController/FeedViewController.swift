//
//  FeedViewController.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
    
    // MARK: Costant
    private enum Constant {
        static let title = "Have a good Day!"
    }
    
    // MARK: View
    private lazy var contentView = FeedListView()
    
    // MARK: Properties
    private let viewModel: FeedViewModel
    private var bindings = Set<AnyCancellable>()
    private var feedCollectionDataManager: FeedCollectionDataManager?
    
    // MARK: Init
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
        setUpCollectionView()
        configureDataSource()
        setUpBinding()
        setupView()
    }
}

// MARK: - Funcs
extension FeedViewController {
    private func setupView() {
        title = Constant.title
        view.backgroundColor = .systemGray4
    }
    
    private func setUpCollectionView() {
        contentView.collectionView.register(FeedCollectionViewCell.self,
                                            forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
    }
    
    private func setUpBinding() {
        viewModel.$launchs
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.feedCollectionDataManager?.updateSections(launchs: self?.viewModel.launchs)
            }
            .store(in: &bindings)
        
        let stateValueHandler: (FeedViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.contentView.startLoading()
            case .finishedLoading:
                self?.contentView.finishLoading()
            case .error(let errorString):
                self?.contentView.finishLoading()
                self?.showError(errorString)
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
        
    }
    
    private func configureDataSource() {
        feedCollectionDataManager = FeedCollectionDataManager(
            collectionView: contentView.collectionView,
            output: self.viewModel
        )
        feedCollectionDataManager?.configure()
    }
}
