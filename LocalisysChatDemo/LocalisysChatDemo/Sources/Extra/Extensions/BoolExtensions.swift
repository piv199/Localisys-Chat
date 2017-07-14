//
//  BoolExtensions.swift
//  LocalisysChatDemo
//
//  Created by Oleksii Pyvovarov on 7/6/17.
//  Copyright © 2017 Oleksii Pyvovarov. All rights reserved.
//

import Foundation

extension Bool {
  @discardableResult func ifTrue(_ perform: (Void) -> (Void)) -> Bool {
    if self { perform() }
    return self
  }

  @discardableResult func ifFalse(_ perform: (Void) -> (Void)) -> Bool {
    if !self { perform() }
    return self
  }
}
