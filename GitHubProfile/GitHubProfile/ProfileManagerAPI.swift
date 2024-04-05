//
//  SceneDelegate.swift
//  GitHubProfile
//
//  Created by David Jang on 3/28/24.
//

import Foundation
import UIKit

class ProfileManagerAPI {
    static let shared = ProfileManagerAPI()
    
    func getUsers(for username: String) async throws -> Profile {
        guard let url = URL(string: "https://api.github.com/users/mgynsz") else {
            throw URLError(.badURL)
        }
        
        // 데이터를 비동기적으로 가져옴
        let (data, _) = try await URLSession.shared.data(from: url)
        var user = try JSONDecoder().decode(Profile.self, from: data)
        
        // 프로필 이미지 URL이 제공되는 경우에만 이미지를 가져옴
        if let avatarURL = URL(string: user.avatarURL) {
            // 이미지 데이터를 비동기적으로 가져옴
            let imageData = try await URLSession.shared.data(from: avatarURL).0
            user.profileImage = UIImage(data: imageData)
        }
        
        return user
    }
}
