//
//  ServerTodosResponseModel.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

struct ServerTODOSResponseModel: Decodable {
    let todos: [ServerTODOModel]?
}
