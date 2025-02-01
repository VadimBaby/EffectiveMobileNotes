//
//  TODO.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

struct TODO {
    let id: Int
    let title: String
    let todo: String
    let completed: Bool
    let createdAt: Date
}

extension TODO {
    init?(from serverModel: ServerTODOModel) {
        guard let id = serverModel.id,
              let todo = serverModel.todo else { return nil }
        
        self.init(
            id: id,
            title: .defaultHeader,
            todo: todo,
            completed: serverModel.completed.orFalse,
            createdAt: .now
        )
    }
}

extension TODO {
    init?(from todoEntity: TODOEntity) {
        guard let title = todoEntity.title,
              let todo = todoEntity.todo,
              let createdAt = todoEntity.createdAt else { return nil }
        
        self.init(
            id: Int(todoEntity.id),
            title: title,
            todo: todo,
            completed: todoEntity.completed,
            createdAt: createdAt
        )
    }
}
