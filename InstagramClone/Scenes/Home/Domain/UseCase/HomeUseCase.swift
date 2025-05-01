//
//  HomeUseCase.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Factory
class HomeUseCase: BaseUseCase, HomeUseCaseProtocol {
    //MARK: -injecting properties
    @Injected(\.homeRepository) private var repository:HomeRepositoryProtocol
    func execute(request: ReelsRequest, completion: @escaping (Result<Reels, InstagramCloneExceptions>) -> Void)  {
        let errors = request.validateRequestContract()
        let filteredErrors = filterErrors(errors: errors)
        if !filteredErrors.isEmpty {
            completion(.failure(.validationError(.fieldErrors(filteredErrors))))
            return
        }
        
        repository.getReels(request: request) { result in
            completion(result)
        }
    }
    
}
