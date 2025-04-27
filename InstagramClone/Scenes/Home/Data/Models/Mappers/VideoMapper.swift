//
//  VideoMapper.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation
import Factory

struct VideoMapper:Mapper {
    
    @Injected(\.userMapper) private var userMapper
    @Injected(\.videoFileMapper) private var videoFileMapper
    @Injected(\.videoPictureMapper) private var videoPictureMapper
    
    func dtoToDomain(_ dto: VideoDTO) -> Video {
        return Video(
            id: dto.id,
            width: dto.width,
            height: dto.height,
            duration: dto.duration,
            fullRes: dto.fullRes,
            tags: dto.tags,
            url: dto.url,
            image: dto.image,
            avgColor: dto.avgColor,
            user: userMapper.dtoToDomain(dto.user),
            videoFiles: dto.videoFiles.map { videoFileMapper.dtoToDomain($0) },
            videoPictures: dto.videoPictures.map { videoPictureMapper.dtoToDomain($0) }
        )
    }
    
    func domainToDto(_ domain: Video) -> VideoDTO {
        return VideoDTO(
            id: domain.id,
            width: domain.width,
            height: domain.height,
            duration: domain.duration,
            fullRes: domain.fullRes,
            tags: domain.tags,
            url: domain.url,
            image: domain.image,
            avgColor: domain.avgColor,
            user: userMapper.domainToDto(domain.user),
            videoFiles: domain.videoFiles.map { videoFileMapper.domainToDto($0) },
            videoPictures: domain.videoPictures.map { videoPictureMapper.domainToDto($0) }
        )
    }
}

