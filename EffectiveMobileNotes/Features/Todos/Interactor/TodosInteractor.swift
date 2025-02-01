//
//  TodosInteractor.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

protocol TodosInteractorOutput: AnyObject {
    func didFetch(todos: [TODO])
}

protocol TodosInteractorInput: AnyObject {
    var output: TodosInteractorOutput? { get set }
    
    func fetchTodos()
}

final class TodosInteractor: TodosInteractorInput {
    weak var output: TodosInteractorOutput?
    
    private let networkService: NetworkServiceProtocol
    private let localDataStorage: LocalDataStorageProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        localDataStorage: LocalDataStorageProtocol
    ) {
        self.networkService = networkService
        self.localDataStorage = localDataStorage
    }
    
    func fetchTodos() {
        if UserStorage.shared.isDataWasLoaded {
            fetchTodosFromLocalStorage { [weak self] todos in
                self?.output?.didFetch(todos: todos)
            }
        } else {
            fetchTodosFromNetwork { [weak self] todos in
                self?.localDataStorage.save(todos: todos)
                UserStorage.shared.isDataWasLoaded = true
                self?.output?.didFetch(todos: todos)
            }
        }
    }
}

private extension TodosInteractor {
    func fetchTodosFromLocalStorage(
        onSuccess: @escaping ([TODO]) -> Void,
        onFailure: ((Error) -> Void)? = nil
    ) {
        do {
            let todos = try localDataStorage.get()
            onSuccess(todos)
        } catch {
            onFailure?(error)
            print(error.localizedDescription)
        }
    }
    
    func fetchTodosFromNetwork(
        onSuccess: @escaping ([TODO]) -> Void,
        onFailure: ((Error) -> Void)? = nil
    ) {
        networkService.getTodos { result in
            switch result {
            case .success(let todos):
                onSuccess(todos)
            case .failure(let error):
                onFailure?(error)
                print(error.localizedDescription)
            }
        }
    }
}
