//
//  VideoPictureMapper.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation

struct VideoPictureMapper:Mapper {
    func dtoToDomain(_ dto: VideoPictureDTO) -> VideoPicture {
        return VideoPicture(
            id: dto.id,
            nr: dto.nr,
            picture: dto.picture
        )
    }
    
    func domainToDto(_ domain: VideoPicture) -> VideoPictureDTO {
        return VideoPictureDTO(
            id: domain.id,
            nr: domain.nr,
            picture: domain.picture
        )
    }
}

