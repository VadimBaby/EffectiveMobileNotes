//
//  Bool.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

extension Optional where Wrapped == Bool {
    var orFalse: Bool {
        self ?? false
    }
}
