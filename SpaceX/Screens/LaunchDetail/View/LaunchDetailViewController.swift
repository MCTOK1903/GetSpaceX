//
//  LaunchDetailViewController.swift
//  SpaceX
//
//  Created by Muhammed Celal Tok on 15.09.2022.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    // MARK: Views
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0, height: view.frame.height)
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .lastBaseline
        stackView.spacing = 8
        return stackView
    }()
    
    private var launchImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var launchName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var launchDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    // MARK: Properties
    private let viewModel: LaunchDetailViewModel
    
    // MARK: Init
    init(viewModel: LaunchDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProperty()
        setUpContents()
    }
    
    // MARK: Funcs
    private func configureProperty() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(launchImage)
        stackView.addArrangedSubview(launchName)
        stackView.addArrangedSubview(launchDescriptionLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        makeScroll()
        makeStack()
        makeImage()
    }
    
    private func setUpContents() {
        self.launchImage.kf.setImage(with: viewModel.launchImageURL)
        self.launchName.text = viewModel.launchName
        self.launchDescriptionLabel.text = viewModel.launchDescription
    }
}

//MARK: - Constraints
extension LaunchDetailViewController {
    private func makeScroll() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.right.equalTo(-8)
            make.left.equalTo(8)
            make.width.equalTo(view.frame.size.width)
        }
    }
    private func makeStack() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    private func makeImage() {
        launchImage.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.frame.size.width)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
