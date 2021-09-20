//
//  LoadingView.swift
//  SberProject
//
//  Created by Алена on 18.09.2021.
//

import UIKit

// Загрузочный экран профиля
final class LoadingView: UIView {
    private let imageViewBox = UIImageView()
    private let imageViewCat = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupImageView()
        setupLabel()
        animationCat()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraintsImageView() {
        imageViewCat.translatesAutoresizingMaskIntoConstraints = false
        imageViewBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageViewCat.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 2) - 180),
            imageViewCat.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width / 2) - 90),
            imageViewCat.widthAnchor.constraint(equalToConstant: 180),
            imageViewCat.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            imageViewBox.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 2) - 180),
            imageViewBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width / 2) - 90),
            imageViewBox.widthAnchor.constraint(equalToConstant: 180),
            imageViewBox.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupImageView() {
        imageViewCat.image = UIImage(named: "cat.png")
        imageViewBox.image = UIImage(named: "box.png")
        
        imageViewCat.isHidden = true
        
        self.addSubview(imageViewCat)
        self.addSubview(imageViewBox)
        
        makeConstraintsImageView()
    }
    
    private func makeConstraintsLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: (boundsDevices.height / 2) + 16),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (boundsDevices.width / 2) - 90),
            label.widthAnchor.constraint(equalToConstant: 180),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupLabel() {
        label.text = "Загружаем данные..."
        label.textAlignment = .center
        label.textColor = .black
        self.addSubview(label)
        makeConstraintsLabel()
    }
    
    func animationCat() {
        let animation = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            self.imageViewCat.isHidden = false
            self.imageViewCat.center = CGPoint(x: self.imageViewCat.center.x, y: -90)
        }
        animation.startAnimation()
    }
}
