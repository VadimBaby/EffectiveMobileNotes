//
//  TODOResponse.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

struct TODOResponse {
    let todos: [TODO]
}

extension TODOResponse {
    init?(from serverEntity: ServerTODOSResponseModel) {
        guard let todos = serverEntity.todos else { return nil }
        
        self.init(
            todos: todos.compactMap{ TODO(from: $0) }
        )
    }
}
