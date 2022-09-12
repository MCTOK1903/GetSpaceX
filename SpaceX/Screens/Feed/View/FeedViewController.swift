//
//  FeedViewController.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
    
    
    // MARK: View
    private lazy var contentView = FeedListView()
    
    // MARK: Properties
    private let viewModel: FeedViewModel
    private var bindings = Set<AnyCancellable>()
    private typealias DataSource = UICollectionViewDiffableDataSource< FeedViewModel.Section, LaunchModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<FeedViewModel.Section, LaunchModel>
    private var dataSource: DataSource?
    
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
        contentView.output = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
        setUpCollectionView()
        configureDataSource()
        setUpBinding()
        setupView()
    }
    
    private func setupView() {
        title = "Have a good Day!"
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
                self?.updateSections()
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
    
    private func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.launch])
        snapshot.appendItems(viewModel.launchs)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func showError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FeedViewController {
    private func configureDataSource() {
        dataSource = DataSource(
            collectionView: contentView.collectionView,
            cellProvider: { (collectionView, indexPath, launch) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FeedCollectionViewCell
                cell?.configureCell(viewModel: FeedCellViewModel(launch: launch))
                return cell
            })
    }
}
