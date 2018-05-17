//
//  LoginViewController.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
  private let viewModel = LoginViewModel()
  
  @IBAction func loginToSpotify(_ sender: UIButton) {
    viewModel.authorizeSpotify(from: self)
  }
}
