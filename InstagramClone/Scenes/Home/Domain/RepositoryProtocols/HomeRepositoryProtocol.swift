//
//  Repository.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
protocol HomeRepositoryProtocol {
    func getReels(request:ReelsRequest,completion:@escaping(Result<Reels,InstagramCloneExceptions>)->Void)
}
