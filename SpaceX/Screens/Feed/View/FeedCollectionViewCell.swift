//
//  FeedCollectionViewCell.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 11.09.2022.
//

import UIKit
import SnapKit
import Kingfisher

class FeedCollectionViewCell: UICollectionViewCell {
    
    // MARK: Views
    
    private let verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let launchImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        return image
    }()
    
    var rocketNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.clipsToBounds = true
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 0
        nameLabel.backgroundColor = .white
        return nameLabel
    }()
    
    // MARK: Properties
    private var viewModel: FeedCellViewModel?
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubView()
        setupconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Func
    
    func configureCell(viewModel: FeedCellViewModel) {
        self.viewModel = viewModel
        backgroundColor = .white
        fillContent()
    }
    
    private func addSubView() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(launchImage)
        verticalStack.addArrangedSubview(rocketNameLabel)
        
        verticalStack.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        launchImage.snp.makeConstraints { make in
            make.height.width.equalTo(contentView.frame.width - 16)
            make.top.leading.equalTo(verticalStack).offset(8)
        }
    }
    
    private func setupconstraints() {
        verticalStack.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    private func fillContent() {
        launchImage.kf.setImage(with: viewModel?.imageURl)
        rocketNameLabel.text = viewModel?.launcName
    }
}
