//
//  SceneDelegate.swift
//  GitHubProfile
//
//  Created by David Jang on 3/28/24.
//

import Foundation

struct Repository: Codable {
    let name: String
    let language: String?
    let stargazerscount: Int

    enum CodingKeys: String, CodingKey {
        case name, language
        case stargazerscount = "stargazers_count"
    }
}

extension ProfileManagerAPI {
    
    func getRepositories(for username: String) async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/users/apple/repos") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let repositories = try JSONDecoder().decode([Repository].self, from: data)
        return repositories
    }
}
