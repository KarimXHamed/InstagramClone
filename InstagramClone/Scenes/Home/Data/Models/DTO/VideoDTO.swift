//
//  VideoDTO.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
struct VideoDTO: Codable {
    let id: Int
    let width: Int
    let height: Int
    let duration: Int
    let fullRes: String?
    let tags: [String]
    let url: String
    let image: String
    let avgColor: String?
    let user: UserDTO
    let videoFiles: [VideoFileDTO]
    let videoPictures: [VideoPictureDTO]

    enum CodingKeys: String, CodingKey {
        case id, width, height, duration
        case fullRes = "full_res"
        case tags, url, image
        case avgColor = "avg_color"
        case user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}
