//
//  AppInitialSegue.swift
//  LocalisysChatDemo
//
//  Created by Oleksii Pyvovarov on 7/6/17.
//  Copyright © 2017 Oleksii Pyvovarov. All rights reserved.
//

import UIKit

final class AppInitialSegue: UIStoryboardSegue {
  override func perform() {
    UIApplication.shared.keyWindow?.rootViewController = destination
  }
}
