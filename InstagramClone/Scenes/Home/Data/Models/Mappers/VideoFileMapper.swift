//
//  VideoFileMapper.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation

struct VideoFileMapper:Mapper {
    func dtoToDomain(_ dto: VideoFileDTO) -> VideoFile {
        return VideoFile(
            id: dto.id,
            quality: dto.quality,
            fileType: dto.fileType,
            width: dto.width,
            height: dto.height,
            fps: dto.fps,
            link: dto.link,
            size: dto.size
        )
    }
    
    func domainToDto(_ domain: VideoFile) -> VideoFileDTO {
        return VideoFileDTO(
            id: domain.id,
            quality: domain.quality,
            fileType: domain.fileType,
            width: domain.width,
            height: domain.height,
            fps: domain.fps,
            link: domain.link,
            size: domain.size
        )
    }
}

