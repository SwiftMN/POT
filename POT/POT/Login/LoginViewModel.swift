//
//  LoginViewModel.swift
//  POT
//
//  Created by Adam Ahrens on 5/16/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit
import OAuthSwift
import Swinject

final class LoginViewModel: NSObject {
  // MARK: Private
  private let spotifyAccess: SpotifyAccess

  // MARK: Public
  @objc dynamic var authorization: Authorization? = nil

  // MARK: Init
  init(container: Container) {
    guard
      let sa = container.resolve(SpotifyAccess.self)
    else { fatalError("No SpotifyAccess") }

    spotifyAccess = sa
  }

  // MARK: Methods
  func authorizeSpotify(from: UIViewController) {
    let authorizeURL = LoginApi.authorize.fullURL
    let tokenURL = LoginApi.token.fullURL
    let oauthswift = OAuth2Swift(consumerKey: spotifyAccess.key,
                             consumerSecret: spotifyAccess.secret,
                             authorizeUrl: authorizeURL.absoluteString,
                             accessTokenUrl: tokenURL.absoluteString,
                             responseType: "code")

    let scopes = "user-library-modify user-top-read playlist-read-private user-read-birthdate"
    let url = "oauth-swift://oauth-callback/spotify"
    let state = UUID.init().uuidString

    let handler = SafariURLHandler(viewController: from, oauthSwift: oauthswift)
    oauthswift.authorizeURLHandler = handler

    let _ = oauthswift.authorize(withCallbackURL: url,
                                 scope: scopes,
                                 state: state,
                                 success: { [weak self] credential, response, params in
                                  self?.authorization = Authorization(type: "Bearer", accessToken: credential.oauthToken)
    }) { error in
      print("Error")
    }
  }
}
