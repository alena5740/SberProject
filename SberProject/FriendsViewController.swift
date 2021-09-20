//
//  FriendsViewController.swift
//  SberProject
//
//  Created by Алена on 20.08.2021.
//

import UIKit

// Контроллер для отображения списка друзей
final class FriendsViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var friendsPresenter: FriendsPresenterProtocol?
        
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupTableView()
        setupNavigation()
        friendsPresenter?.getModel(success: {
            self.tableView.reloadData()
        })
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Мои друзья"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "FriendsTableViewCell")
        makeConstraintsTableView()
    }
    
    private func makeConstraintsTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsPresenter?.arrayModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsTableViewCell.reuseIdentifier, for: indexPath) as! FriendsTableViewCell
        if let presenter = friendsPresenter, let model = presenter.arrayModel[indexPath.row] {
            cell.configure(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(profileService: GetProfileService(), photoService: GetPhotoService())
        profilePresenter.viewDelegate = profileViewController
        profileViewController.presenter = profilePresenter
        if let presenter = friendsPresenter {
            let model = presenter.arrayModel[indexPath.row]
            let id = model?.id
            profilePresenter.userID = id!.description
            profileViewController.titleNavigationController = "\(model?.name ?? "")"
        }
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
