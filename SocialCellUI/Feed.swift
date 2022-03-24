//
//  Feed.swift
//  SocialCellUI
//
//  Created by 김정민 on 2022/03/24.
//

import UIKit


struct Feed: Codable {
    
    struct Author: Codable {
        let name: String
        private let profileImageName: String
        var profileImage: UIImage? {
            return UIImage(named: self.profileImageName)
        }
    }
    
    struct Content: Codable {
        let text: String?
        private let imageName: String?
        var image: UIImage? {
            guard let name: String = self.imageName else { return nil }
            return UIImage(named: name)
        }
    }
    
    let author: Author
    let time: String
    let contents: Content
    let likes: Int

}

extension Feed {
    
    static let feeds: [Feed] = {
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "sample") else { return [] }
        let jsonDecoder: JSONDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let feeds: [Feed] = try jsonDecoder.decode([Feed].self, from: dataAsset.data)
            return feeds
        } catch {
            print(error)
            return []
        }
    }()

}
