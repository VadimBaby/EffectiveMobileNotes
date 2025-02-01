//
//  TODOServerModel.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

struct ServerTODOModel: Decodable {
    let id: Int?
    let todo: String?
    let completed: Bool?
}
