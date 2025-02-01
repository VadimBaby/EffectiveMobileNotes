//
//  TodoAssembly.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation
import UIKit

final class TodosAssembly {
    static func assemble() -> UIViewController & TodosPresenterInput {
        let networkService = NetworkService()
        let localDataStorage = LocalDataStorage()
        let view = TodosView()
        let interactor = TodosInteractor(networkService: networkService, localDataStorage: localDataStorage)
        let presenter = TodosPresenter(interactor: interactor) {
            return view
        }
        
        interactor.output = presenter
        
        return presenter
    }
}
