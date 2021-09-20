//
//  FriendsTableViewCell.swift
//  SberProject
//
//  Created by Алена on 20.08.2021.
//

import UIKit

// Ячейка с информацией о друге 
final class FriendsTableViewCell: UITableViewCell {
    private let name = UILabel()
    private let photoAvatar = UIImageView()
    static let reuseIdentifier = "FriendsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupPhoto()
        setupName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraintsPhoto() {
        photoAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            photoAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoAvatar.widthAnchor.constraint(equalToConstant: boundsDevices.width / 9.28),
            photoAvatar.heightAnchor.constraint(equalToConstant: boundsDevices.width / 9.28)
        ])
    }
    
    private func setupPhoto() {
        contentView.addSubview(photoAvatar)
        makeConstraintsPhoto()
        photoAvatar.clipsToBounds = true
        photoAvatar.layer.cornerRadius = (boundsDevices.width / 9.28) / 2
    }
    
    private func makeConstraintsName() {
        name.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            name.leadingAnchor.constraint(equalTo: photoAvatar.trailingAnchor, constant: 16),
            name.widthAnchor.constraint(equalToConstant: boundsDevices.width / 1.3),
            name.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupName() {
        contentView.addSubview(name)
        name.textColor = .black
        makeConstraintsName()
    }
    
    func configure(model: FriendsModel) {
        let text = "\(model.name ?? "") \(model.surname ?? "")"
        name.text = text
        photoAvatar.loadImage(imageString: model.photoAvatar ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        photoAvatar.image = nil
    }
}
