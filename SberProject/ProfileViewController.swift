//
//  ProfileViewController.swift
//  SberProject
//
//  Created by Алена on 12.08.2021.
//

import UIKit

// Контроллер для отображения профиля
final class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    private let loadingView = LoadingView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = distanceBetweenCells
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var titleNavigationController = "Мой профиль"
    var presenter: ProfilePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setupNavigation()
        let userID = presenter?.userID ?? ""
        presenter?.getData(userID: userID)
        presenter?.getPhotos(userID: userID)
        setupLoadingView()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = titleNavigationController        
    }
    
    private func setup() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.register(ProfileGalleryCollectionViewCell.self, forCellWithReuseIdentifier: ProfileGalleryCollectionViewCell.reuseIdentifier)
        collectionView.register(ProfileInfoCollectionViewCell.self, forCellWithReuseIdentifier: ProfileInfoCollectionViewCell.reuseIdentifier)
        makeConstraints()
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.frame = self.view.frame
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0
        }
        return presenter.modelPhotosSmallArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileInfoCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileInfoCollectionViewCell
            if let presenter = presenter, let model = presenter.model {
                cell?.configure(model: model)
            }
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileGalleryCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileGalleryCollectionViewCell
            if let presenter = presenter, !presenter.modelPhotosSmallArray.isEmpty {
                let model = presenter.modelPhotosSmallArray
                cell?.configure(model: model[indexPath.item - 1])
            }
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: boundsDevices.width - 32, height: (boundsDevices.width / 3.25) + 40)
        } else {
            return CGSize(width: boundsGalleryCell, height: boundsGalleryCell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoViewController = PhotoViewController()
        if indexPath.item != 0 {
            if let presenter = presenter, !presenter.modelPhotosLargeArray.isEmpty {
                let photo = presenter.modelPhotosLargeArray[indexPath.item - 1]
                photoViewController.configurePhoto(model: photo)
            }
            self.navigationController?.pushViewController(photoViewController, animated: true)
        }
    }
}


// MARK: - ProfileViewOutputProtocol
extension ProfileViewController: ProfileViewOutputProtocol {
    func hideLoadingView(isHidden: Bool) {
        loadingView.isHidden = isHidden
    }
    
    func updateView() {
        collectionView.reloadData()
    }
}
