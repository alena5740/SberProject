//
//  FilterCollectionViewCell.swift
//  SberProject
//
//  Created by Алена on 08.09.2021.
//

import UIKit

// Ячейка с фильтрами для обработки фотографии
final class FilterCollectionViewCell: UICollectionViewCell {
    private let filterImage: UIImageView = {
        let figureImage = UIImageView()
        figureImage.translatesAutoresizingMaskIntoConstraints = false
        return figureImage
    }()
        
    static let reuseIdentifier = "FilterCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            filterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterImage.widthAnchor.constraint(equalToConstant: boundsGalleryCell),
            filterImage.heightAnchor.constraint(equalToConstant: boundsGalleryCell)
        ])
    }
    
    private func setup() {
        contentView.addSubview(filterImage)
        makeConstraints()
    }
    
    func setFigureImage(filterImage: UIImage)  {
        self.filterImage.image = filterImage
    }
}
