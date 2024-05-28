//
//  Listenable.swift
//  SwiftUIIntergrationProject
//
//  Created by Satyarth Kumar Prasad on 28/05/24.
//

import Foundation

public final class Listenable<Value> {
  
  private var closure: ((Value) -> ())?
  
  public var value: Value {
    didSet { closure?(value) }
  }
  
  public init(_ value: Value) {
    self.value = value
  }
  
  public func observe(_ closure: @escaping (Value) -> Void) {
    self.closure = closure
    closure(value)
  }
  
}
