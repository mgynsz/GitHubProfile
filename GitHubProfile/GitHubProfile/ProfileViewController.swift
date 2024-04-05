//
//  SceneDelegate.swift
//  GitHubProfile
//
//  Created by David Jang on 3/28/24.
//

import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate {
    
    private var tableView: UITableView!
    private var repositories: [Repository] = []
    private var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupProfileHeaderView()
        setupTableView()
        
        Task {
            await fetchUserProfile(for: "mgynsz")
            await fetchRepositories(for: "apple")
        }
    }
    
    private func setupProfileHeaderView() {
        profileView = ProfileView()
        profileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func fetchUserProfile(for username: String) async {
        do {
            let userProfile = try await ProfileManagerAPI.shared.getUsers(for: username)
            DispatchQueue.main.async { [weak self] in
                self?.profileView.userProfile = userProfile
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchRepositories(for username: String) async {
        do {
            repositories = try await ProfileManagerAPI.shared.getRepositories(for: username)
            repositories.sort(by: { $0.stargazerscount > $1.stargazerscount })
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = "\(repository.name) (⭐️\(repository.stargazerscount) )"
        return cell
    }
}
