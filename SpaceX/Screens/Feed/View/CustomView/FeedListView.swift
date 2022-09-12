//
//  FeedListView.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation
import UIKit

protocol FeedListViewOutput: AnyObject {
    func checkPagination(lastVisibleItemIndexPath: IndexPath?)
}

final class FeedListView: UIView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var activityIndicationView = UIActivityIndicatorView(style: .medium)
    weak var output: FeedListViewOutput?

    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        setupSubView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Funcs
extension FeedListView {
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        collectionView.isUserInteractionEnabled = true
        activityIndicationView.isHidden = true
        activityIndicationView.stopAnimating()
    }
}

// MARK: - Private Funcs
extension FeedListView {
    
    private func setUpConstraints() {
        let defaultMargin: CGFloat = 4.0
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: defaultMargin),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupSubView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        
        addSubview(activityIndicationView)
        activityIndicationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let fraction: CGFloat = 1 / 2
        let inset: CGFloat = 5

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/3.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                        leading: inset,
                                                        bottom: inset,
                                                        trailing: inset)
        
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, _, _) in
            self?.output?.checkPagination(lastVisibleItemIndexPath: visibleItems.last?.indexPath)
        }
        return UICollectionViewCompositionalLayout(section: section)
    }
}
