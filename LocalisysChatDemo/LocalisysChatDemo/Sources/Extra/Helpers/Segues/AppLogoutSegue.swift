//
//  AppLogoutSegue.swift
//  LocalisysChatDemo
//
//  Created by Oleksii Pyvovarov on 7/6/17.
//  Copyright © 2017 Oleksii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseAuth

final class AppLogoutSegue: UIStoryboardSegue {
  override func perform() {
    try? Auth.auth().signOut()
  }
}

