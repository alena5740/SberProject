//
//  ProfileInfoCollectionViewCell.swift
//  SberProject
//
//  Created by Алена on 20.08.2021.
//

import UIKit

// Ячейка с информацией о пользователе 
final class ProfileInfoCollectionViewCell: UICollectionViewCell {
    private var photoProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name = UILabel()
    private let dateOfBirth = UILabel()
    private let city = UILabel()
    
    static let reuseIdentifier = "ProfileInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupPhotoProfile()
        setupNameLabel()
        setupDateOfBirthLabel()
        setupCityLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraintsPhotoProfile() {
        NSLayoutConstraint.activate([
            photoProfile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoProfile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            photoProfile.widthAnchor.constraint(equalToConstant: boundsDevices.width / 3.25),
            photoProfile.heightAnchor.constraint(equalToConstant: boundsDevices.width / 3.25)
        ])
    }
    
    private func setupPhotoProfile() {
        contentView.addSubview(photoProfile)
        makeConstraintsPhotoProfile()
        photoProfile.layer.cornerRadius = (boundsDevices.width / 3.25) / 2
        photoProfile.clipsToBounds = true
    }
    
    private func makeConstraintsNameLabel() {
        name.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: (boundsDevices.width - photoProfile.bounds.width) - 48),
            name.heightAnchor.constraint(equalToConstant: 60),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: photoProfile.trailingAnchor, constant: 22)
        ])
    }
    
    private func setupNameLabel() {
        contentView.addSubview(name)
        makeConstraintsNameLabel()
        name.font = UIFont.boldSystemFont(ofSize: 22)
        name.numberOfLines = 2
        name.textColor  = .black
    }
    
    private func makeConstraintsDateOfBirthLabel() {
        dateOfBirth.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateOfBirth.widthAnchor.constraint(equalToConstant: (boundsDevices.width - photoProfile.bounds.width) - 48),
            dateOfBirth.heightAnchor.constraint(equalToConstant: 30),
            dateOfBirth.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 82),
            dateOfBirth.leadingAnchor.constraint(equalTo: photoProfile.trailingAnchor, constant: 22)
        ])
    }
    
    private func setupDateOfBirthLabel() {
        contentView.addSubview(dateOfBirth)
        dateOfBirth.textColor = .black
        dateOfBirth.font = UIFont.systemFont(ofSize: 15)
        makeConstraintsDateOfBirthLabel()
    }
    
    private func makeConstraintsCityLabel() {
        city.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            city.widthAnchor.constraint(equalToConstant: (boundsDevices.width - photoProfile.bounds.width) - 48),
            city.heightAnchor.constraint(equalToConstant: 30),
            city.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 108),
            city.leadingAnchor.constraint(equalTo: photoProfile.trailingAnchor, constant: 22)
        ])
    }
    
    private func setupCityLabel() {
        contentView.addSubview(city)
        city.textColor = .black
        city.font = UIFont.systemFont(ofSize: 15)
        makeConstraintsCityLabel()
    }
    
    func configure(model: ProfileModel) {
        photoProfile.loadImage(imageString: model.photoAvatar ?? "")
        var dateResult = ""
        if let date = model.dateOfBirth {
            dateResult = date.birthdayFormatter()
        } else {
            dateResult = "Не указан"
        }
        
        let countText = Int(model.name?.count ?? 0) + Int(model.surname?.count ?? 0)
        if countText > 14 {
            name.text = """
                \(model.name ?? "")
                \(model.surname ?? "")
                """
        } else {
            name.text = "\(model.name ?? "") \(model.surname ?? "")"
        }
        
        city.text = "Город: \(model.city ?? "Не указан")"
        dateOfBirth.text = "День рождения: \(dateResult)"
    }
}
