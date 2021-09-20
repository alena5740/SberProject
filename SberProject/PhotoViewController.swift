//
//  PhotoViewController.swift
//  SberProject
//
//  Created by Алена on 22.08.2021.
//

import UIKit

// Контроллер для отображения экрана фоторедактора
final class PhotoViewController: UIViewController {
    private let photoOriginal = UIImageView()
    private var photoEdited = UIImageView()
    private var modeEdit = false
    private lazy var filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = distanceBetweenCells
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: boundsGalleryCell, height: boundsGalleryCell)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupPhotoOriginal()
        setupPhotoEdited()
        setupNavigation()
        setupFilterCollectionView()
    }
    
    private func setupNavigation() {
        if modeEdit {
            self.navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(buttonSharePressed)),
                UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(buttonClosePressed))
            ]
        } else {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(buttonEditPressed))
        }
    }
    
    private func makeConstraintsPhotoOriginal() {
        photoOriginal.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoOriginal.topAnchor.constraint(equalTo: view.topAnchor, constant: boundsDevices.height / 5),
            photoOriginal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photoOriginal.widthAnchor.constraint(equalToConstant: boundsDevices.width - 32),
            photoOriginal.heightAnchor.constraint(equalToConstant: boundsDevices.width - 32)
        ])
    }
    
    private func setupPhotoOriginal() {
        view.addSubview(photoOriginal)
        photoOriginal.contentMode = .scaleAspectFill
        photoOriginal.clipsToBounds = true
        makeConstraintsPhotoOriginal()
    }
    
    private func makeConstraintsPhotoEdited() {
        photoEdited.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoEdited.topAnchor.constraint(equalTo: view.topAnchor, constant: boundsDevices.height / 5),
            photoEdited.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photoEdited.widthAnchor.constraint(equalToConstant: boundsDevices.width - 32),
            photoEdited.heightAnchor.constraint(equalToConstant: boundsDevices.width - 32)
        ])
    }
    
    private func setupPhotoEdited() {
        view.addSubview(photoEdited)
        photoEdited.contentMode = .scaleAspectFill
        photoEdited.clipsToBounds = true
        makeConstraintsPhotoEdited()
        photoEdited.alpha = 0
    }
    
    private func makeConstraintsFilterCollectionView() {
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: ((boundsDevices.height / 4) * 2.85)),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterCollectionView.widthAnchor.constraint(equalToConstant: boundsDevices.width - 32),
            filterCollectionView.heightAnchor.constraint(equalToConstant: boundsGalleryCell)
        ])
    }
    
    private func setupFilterCollectionView() {
        view.addSubview(filterCollectionView)
        filterCollectionView.alpha = 0
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
        makeConstraintsFilterCollectionView()
    }
    
    @objc func buttonEditPressed() {
        photoEdited.image = photoOriginal.image
        modeEdit = true
        filterCollectionView.alpha = 1
        setupNavigation()
        photoOriginal.alpha = 0
        photoEdited.alpha = 1
    }
    
    @objc func buttonClosePressed() {
        modeEdit = false
        filterCollectionView.alpha = 0
        setupNavigation()
        photoOriginal.alpha = 1
        photoEdited.alpha = 0
    }
    
    @objc func buttonSharePressed() {
        var activityItems: [UIImage] = []
        if let photo = photoEdited.image {
            activityItems = [photo]
        }
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            self.photoOriginal.alpha = 1
            self.photoEdited.alpha = 0
            self.setupNavigation()
        }
        modeEdit = false
        filterCollectionView.alpha = 0
    }
    
    func configurePhoto(model: PhotoLargeModel) {
        guard let url = model.largePhotoURL.url else { return }
        photoOriginal.loadImage(imageString: url)
        photoEdited.loadImage(imageString: url)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath) as? FilterCollectionViewCell
        if let image = UIImage(named: "\(indexPath.item)filter.jpeg") {
            cell?.setFigureImage(filterImage: image)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = FilterButtons()
        photoEdited.image = photoOriginal.image
        filter.filterCIPhotoEffect(imageView: photoEdited, indexPath: indexPath.item)
    }
}
