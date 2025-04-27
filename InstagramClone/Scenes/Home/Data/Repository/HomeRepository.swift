//
//  HomeRepository.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Factory
class HomeRepository: HomeRepositoryProtocol {
//MARK: -injecting properties
    @Injected(\.homeRemoteDataSource) private var remoteDataSource: HomeRemoteDataSourceProtocol

    func getReels(request:ReelsRequest,completion:@escaping(Result<Reels,InstagramCloneExceptions>)->Void) {
        remoteDataSource.getReels(request: request){ result in
            switch result {
            case .success(let reels):
                let mapper = ReelsMapper()
                let mappedReels = mapper.dtoToDomain(reels)
                completion(.success(mappedReels))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
        
    }

}
