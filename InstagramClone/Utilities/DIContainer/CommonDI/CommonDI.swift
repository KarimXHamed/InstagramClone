//
//  CommonDI.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Factory
extension Container {
    
    var networkProvider:Factory<NetworkProviderProtocol>{
        self {NetworkProvider()}
    }
}
