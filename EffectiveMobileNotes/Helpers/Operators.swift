//
//  Operators.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 28.01.2025.
//

import Foundation

precedencegroup FunctionApplicationPrecedence {
  associativity: left
  higherThan: BitwiseShiftPrecedence
}

infix operator &>: FunctionApplicationPrecedence

@discardableResult
public func &> <Input>(value: Input, function: (inout Input) throws -> Void) rethrows -> Input {
  var m_value = value
  try function(&m_value)
  return m_value
}
