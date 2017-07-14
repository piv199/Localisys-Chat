//
//  LaunchController.swift
//  LocalisysChatDemo
//
//  Created by Oleksii Pyvovarov on 7/6/17.
//  Copyright © 2017 Oleksii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseAuth

extension Auth {
  var isAuthenticated: Bool { return currentUser != nil }
}

final class LaunchController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    Auth.auth().addStateDidChangeListener { [] (auth, user) in
      auth.isAuthenticated
        .ifTrue(self.showMainScreen)
        .ifFalse(self.showAuthScreen)
    }
  }

  // MARK: - Navigation

  fileprivate func showAuthScreen() { showScreen("Auth") }
  fileprivate func showMainScreen() { showScreen("Main") }


  fileprivate func showScreen(_ screenIdentifier: String) {
    performSegue(withIdentifier: screenIdentifier, sender: self)
  }

}
