//
//  ProfileModel.swift
//  GitHubProfile
//
//  Created by David Jang on 3/28/24.
//

import UIKit

struct Profile: Codable {
    let login: String
    let id: Int
    let name: String
    let avatarURL: String
    let location: String?
    let followers: Int
    let following: Int
    var profileImage: UIImage?
    
    private enum CodingKeys: String, CodingKey {
            case login, id, name, avatarURL = "avatar_url"
            case location, followers, following
        }
}

