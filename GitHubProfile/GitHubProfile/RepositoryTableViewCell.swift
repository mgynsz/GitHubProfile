//
//  SceneDelegate.swift
//  GitHubProfile
//
//  Created by David Jang on 3/28/24.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let languageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(languageLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            languageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            languageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error: ")
    }
    
    func configure(with repository: Repository) {
        nameLabel.text = repository.name
        languageLabel.text = repository.language
    }
}
