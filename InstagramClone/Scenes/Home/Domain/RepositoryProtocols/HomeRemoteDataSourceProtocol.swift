//
//  HomeRemoteDataSourceProtocol.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
protocol HomeRemoteDataSourceProtocol {
    func getReels(request:ReelsRequest,completion:@escaping(Result<ReelsDTO,InstagramCloneExceptions>)->Void)
}
