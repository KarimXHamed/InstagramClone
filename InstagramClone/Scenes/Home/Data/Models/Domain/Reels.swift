//
//  Reels.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation

struct Reels: Codable {
    let page: Int
    let perPage: Int
    let videos: [Video]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case videos
    }
}
