//
//  HomeRemoteDataSource.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Factory
class HomeRemoteDataSource:HomeRemoteDataSourceProtocol {
    //MARK: -injection properties
    @Injected(\.networkProvider) private var networkProvider: NetworkProviderProtocol
    
    //MARK: -tasks
    private var getReelsTaks:Task<Void,Never>?
    
    func getReels(request:ReelsRequest,completion:@escaping(Result<ReelsDTO,InstagramCloneExceptions>)->Void) {
        getReelsTaks = Task {
            do {
                let reelsResponse = try await networkProvider.get(endpoint: request, model: ReelsDTO.self)
                if Task.isCancelled{return}
                completion(.success(reelsResponse))
            }catch{
                let instagramCloneExceptions = error as? InstagramCloneExceptions
                completion(.failure(instagramCloneExceptions!))
            }
            
       }
    }
    
}

