//
//  HomeUseCaseProtocol.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
protocol HomeUseCaseProtocol {
    func execute(request: ReelsRequest, completion: @escaping (Result<Reels, InstagramCloneExceptions>) -> Void)
}
