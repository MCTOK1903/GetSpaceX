//
//  FeedCollectionDataManager.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 12.09.2022.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource< FeedViewModel.Section, LaunchModel>
typealias Snapshot = NSDiffableDataSourceSnapshot<FeedViewModel.Section, LaunchModel>

protocol FeedCollectionDataManagerOutput {
    func onDidSelect(indexPath: IndexPath)
    func onWillDisplay(indexPath: IndexPath)
}

final class FeedCollectionDataManager: NSObject {
    
    // MARK: Properties
    private let collectionView: UICollectionView
    private var dataSource: DataSource?
    
    var output: FeedCollectionDataManagerOutput?
    
    // MARK: Init
    init(collectionView: UICollectionView,
         output: FeedCollectionDataManagerOutput
    ) {
        self.collectionView = collectionView
        self.output = output
        super.init()
    }
    
    // MARK: Public Func
    func configure() {
        configureDataSource()
    }
    
    func updateSections(launchs: [LaunchModel]?) {
        var snapshot = Snapshot()
        snapshot.appendSections([.launch])
        snapshot.appendItems(launchs ?? [])
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Private Func
    private func configureDataSource() {
        collectionView.delegate = self
        dataSource = DataSource(
            collectionView: collectionView,
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

// MARK: - UICollectionViewDelegate
extension FeedCollectionDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.output?.onWillDisplay(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output?.onDidSelect(indexPath: indexPath)
    }
}
