//
//  ReelsMapper.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation
import Factory

struct ReelsMapper:Mapper {
    
    @Injected(\.videoMapper) private var videoMapper
    
    func dtoToDomain(_ dto: ReelsDTO) -> Reels {
        return Reels(
            page: dto.page,
            perPage: dto.perPage,
            videos: dto.videos.map { videoMapper.dtoToDomain($0) }
        )
    }
    
    func domainToDto(_ domain: Reels) -> ReelsDTO {
        return ReelsDTO(
            page: domain.page,
            perPage: domain.perPage,
            videos: domain.videos.map { videoMapper.domainToDto($0) }
        )
    }
}

