//
//  LoginEndpoint.swift
//  POT
//
//  Created by Adam Ahrens on 5/14/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

enum LoginApi {
  case authorize, token
}

extension LoginApi : Endpoint {
  var baseURL: URL {
    guard
      let url = URL(string: "https://accounts.spotify.com")
    else { fatalError("Terrible URL") }

    return url
  }

  var path: String {
    switch self {
    case .authorize:
      return "authorize"
    case .token:
      return "api/token"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .authorize:
      return .get
    case .token:
      return .post
    }
  }

  var task: HTTPTask? {
    return nil
  }

  var headers: HTTPHeaders? {
    return nil
  }
}
