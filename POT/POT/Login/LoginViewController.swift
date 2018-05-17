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
import Lottie

final class LoginViewController: UIViewController {
  
  @objc private var viewModel: LoginViewModel!

  @IBOutlet weak var viewTop: UIButton!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var animationContainer: UIView!
  private var observers = [NSKeyValueObservation]()

  override func viewDidLoad() {
    super.viewDidLoad()

    viewTop.isHidden = true

    let container = Injector.shared.container
    let loader = PlistPropertyLoader(bundle: .main, name: "SpotifyAccess")
    try! container.applyPropertyLoader(loader)
    container.register(SpotifyAccess.self) { resolver in
      let key: String = resolver.property("key")!
      let secret: String = resolver.property("secret")!
      return SpotifyAccess(key: key, secret: secret)
    }

    viewModel = LoginViewModel(container: container)

    setupObservations()
  }

  @IBAction func loginToSpotify(_ sender: UIButton) {
    viewModel.authorizeSpotify(from: self)
  }

  private func setupObservations() {
    observers = [
          viewModel.observe(\.authorization, options: [.new]) { [weak self] object, change in
              if let auth = object.authorization {

                // INJECTION
                Injector.shared.container.register(Authorization.self) { resolver in
                  return auth
                }

                Injector.shared.container.register(NetworkService.self) { resolver in
                  return Service()
                }

                self?.viewTop.isHidden = false
                self?.loginButton.isHidden = true
                DispatchQueue.main.async {
                  self?.configureAnimation()
                }
              }
            }]
  }

  private func configureAnimation() {
    let lottie = LOTAnimationView(name: "techno_penguin")
    lottie.contentMode = .scaleAspectFit
    lottie.frame = animationContainer.frame
    animationContainer.addSubview(lottie)
    lottie.loopAnimation = true
    lottie.play()
  }
}
