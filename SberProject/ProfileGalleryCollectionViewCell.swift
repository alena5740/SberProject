//
//  ProfileGalleryCollectionViewCell.swift
//  SberProject
//
//  Created by Алена on 20.08.2021.
//

import UIKit

// Ячейка с фотографией для профиля
final class ProfileGalleryCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static let reuseIdentifier = "ProfileGalleryCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: boundsGalleryCell),
            imageView.heightAnchor.constraint(equalToConstant: boundsGalleryCell)
        ])
    }
    
    private func setup() {
        contentView.addSubview(imageView)
        makeConstraints()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func configure(model: PhotoSmallModel) {
        guard let url = model.smallPhotoURL.url else { return }
        imageView.loadImage(imageString: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.isHidden = false
        imageView.isHighlighted = false
        imageView.image = nil
    }
}
