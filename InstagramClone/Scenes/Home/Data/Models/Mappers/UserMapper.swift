//
//  UserMapper.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation

struct UserMapper:Mapper {
    typealias Dto = UserDTO
    typealias Domain = User
    
    func dtoToDomain(_ dto: UserDTO) -> User {
        return User(id: dto.id, name: dto.name, url: dto.url)
    }
    
    func domainToDto(_ domain: User) -> UserDTO {
        return UserDTO(id: domain.id, name: domain.name, url: domain.url)
    }
}
