//
//  FeedListView.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import Foundation
import UIKit
import SnapKit

final class FeedListView: UIView {
    
    // MARK: Constant
    private enum Constant {
        static let activityIndicationHeight = 50
    }
    
    // MARK: View
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    lazy var activityIndicationView = UIActivityIndicatorView(style: .medium)

    // MARK: Init
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
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self)
        }
        
        activityIndicationView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.height.width.equalTo(Constant.activityIndicationHeight)
        }
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
        let fractionHeight: CGFloat = 1 / 3.5
        let inset: CGFloat = 5

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(fractionHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                        leading: inset,
                                                        bottom: inset,
                                                        trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
