//
//  LoginViewController.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit
import Swinject
import SwinjectPropertyLoader

final class LoginViewController: UIViewController {
  private var viewModel: LoginViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    let container = Container()
    let loader = PlistPropertyLoader(bundle: .main, name: "SpotifyAccess")
    try! container.applyPropertyLoader(loader)

    container.register(SpotifyAccess.self) { resolver in
      let key: String = resolver.property("key")!
      let secret: String = resolver.property("secret")!
      return SpotifyAccess(key: key, secret: secret)
    }

    viewModel = LoginViewModel(container: container)
  }

  @IBAction func loginToSpotify(_ sender: UIButton) {
    viewModel.authorizeSpotify(from: self)
  }
}
