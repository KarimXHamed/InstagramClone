//
//  ReelsDTO.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation

struct ReelsDTO: Codable {
    let page: Int
    let perPage: Int
    let videos: [VideoDTO]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case videos
    }
}
