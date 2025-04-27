//
//  HomeViewModel.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Factory
import Combine

class HomeViewModel:BaseViewModel,HomeViewModelProtocol {
    //MARK: -injection properties
    @Injected(\.homeUseCase) private var useCase: HomeUseCaseProtocol
    
    //MARK: -variables
    var dataSourceInjection: (() -> Void)?

    
    //MARK: -lifeCycle
    func viewWillAppear() {
        dataSourceInjection?()

        let request = ReelsRequest()
        useCase.execute(request: request) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
                
            }
            
        }
    }
}
