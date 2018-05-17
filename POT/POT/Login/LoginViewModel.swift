//
//  LoginViewModel.swift
//  POT
//
//  Created by Adam Ahrens on 5/16/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit
import OAuthSwift

final class LoginViewModel {

  func authorizeSpotify(from: UIViewController) {
    let tokenURL = "https://accounts.spotify.com/api/token"
    let authorizeURL = "https://accounts.spotify.com/authorize"

    let oauthswift = OAuth2Swift(consumerKey: "",
                             consumerSecret: "",
                             authorizeUrl: authorizeURL,
                             accessTokenUrl: tokenURL,
                             responseType: "code")

    let scopes = "user-library-modify user-top-read playlist-read-private user-read-birthdate"
    let url = "oauth-swift://oauth-callback/spotify"
    let state = UUID.init().uuidString

    let handler = SafariURLHandler(viewController: from, oauthSwift: oauthswift)
    oauthswift.authorizeURLHandler = handler

    let _ = oauthswift.authorize(withCallbackURL: url, scope: scopes, state: state, success: { credential, response, params in
      print("Succes")
      print("Credentials: \(credential.oauthToken)")
    }) { erro in
      print("Error")
    }
  }
}
