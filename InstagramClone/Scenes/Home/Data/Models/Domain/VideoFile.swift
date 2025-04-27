//
//  VideoFile.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
struct VideoFile: Codable {
    let id: Int
    let quality: String
    let fileType: String
    let width: Int
    let height: Int
    let fps: Double
    let link: String
    let size: Int

    enum CodingKeys: String, CodingKey {
        case id, quality
        case fileType = "file_type"
        case width, height, fps, link, size
    }
}
