//
//  LocalDataStorage.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 29.01.2025.
//

import Foundation
import CoreData

// MARK: - Constants

fileprivate let CONTAINER_NAME = "Model"
fileprivate let ENTITY_NAME = "TODOEntity"

// MARK: - Protocol

protocol LocalDataStorageProtocol {
    func save(todo: TODO)
    func save(todos: [TODO])
    
    func get() throws -> [TODO]
}

// MARK: - LocalDataStorage

final class LocalDataStorage: LocalDataStorageProtocol {
    private let container = NSPersistentContainer(name: CONTAINER_NAME)
    
    private lazy var context: NSManagedObjectContext = container.newBackgroundContext()
    
    init() {
        loadPersistentStore()
    }
    
    func save(todo: TODO) {
        performBackgroundTask { [weak self] in
            guard let self = self else { return }
            
            let todoEntity = TODOEntity(context: context)
            todoEntity.id = Int32(todo.id)
            todoEntity.title = todo.title
            todoEntity.todo = todo.todo
            todoEntity.completed = todo.completed
            todoEntity.createdAt = todo.createdAt
        }
    }
    
    func save(todos: [TODO]) {
        for todo in todos {
            save(todo: todo)
        }
    }
    
    func get() throws -> [TODO] {
        let request = NSFetchRequest<TODOEntity>(entityName: ENTITY_NAME)
        
        let objects = try context.fetch(request)
        
        let todos = objects.compactMap{ TODO(from: $0) }
        
        return todos
    }
}

// MARK: - Private Method

private extension LocalDataStorage {
    func performBackgroundTask(_ block: @escaping () -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }
            block()
            self.saveContext()
        }
    }

    func loadPersistentStore() {
        container.loadPersistentStores { description, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
