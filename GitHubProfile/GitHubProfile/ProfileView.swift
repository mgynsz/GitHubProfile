//
//  SceneDelegate.swift
//  GitHubProfile
//
//  Created by David Jang on 3/28/24.
//

import UIKit

class ProfileView: UIView {
    
    private let profileImageView = UIImageView()
    private let idLabel = UILabel()
    private let nameLabel = UILabel()
    private let locationLabel = UILabel()
    private let followersCountLabel = UILabel()
    private let followingCountLabel = UILabel()
    
    var userProfile: Profile? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(profileImageView)
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(locationLabel)
        addSubview(followersCountLabel)
        addSubview(followingCountLabel)

        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        followersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        followingCountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // 이미지
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // 아이디
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            idLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
//            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            // 이름
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: idLabel.leadingAnchor),
//            nameLabel.trailingAnchor.constraint(equalTo: idLabel.trailingAnchor),
            
            // 지역
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
//            locationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            // 팔로워수
            followersCountLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            followersCountLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
//            followersCountLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor),
            
            // 팔로잉수
            followingCountLabel.topAnchor.constraint(equalTo: followersCountLabel.bottomAnchor, constant: 8),
            followingCountLabel.leadingAnchor.constraint(equalTo: followersCountLabel.leadingAnchor),
//            followingCountLabel.trailingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor),
//            followingCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        styleLabels()
    }
    
    private func styleLabels() {
        
        idLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        locationLabel.font = UIFont.systemFont(ofSize: 14)
        followersCountLabel.font = UIFont.systemFont(ofSize: 14)
        followingCountLabel.font = UIFont.systemFont(ofSize: 14)
        
        idLabel.textColor = .black
        nameLabel.textColor = .black
        locationLabel.textColor = .black
        followersCountLabel.textColor = .black
        followingCountLabel.textColor = .black
        
    }
    
    private func updateUI() {
        guard let userProfile = userProfile else { return }
        profileImageView.image = userProfile.profileImage
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        
        idLabel.text = "아이디: \(userProfile.login)"
        nameLabel.text = "이름: \(userProfile.name)"
        locationLabel.text = "지역: \(userProfile.location ?? "정보 없음")"
        followersCountLabel.text = "팔로우수: \(userProfile.followers)"
        followingCountLabel.text = "팔로잉수: \(userProfile.following)"
    }
}
