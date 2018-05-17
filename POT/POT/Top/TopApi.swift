//
//  TopApi.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

enum Top {
  case tracks, artists
}

struct TopApi {
  let authorization: Authorization
  let top: Top
}

extension TopApi: Endpoint {
  var baseURL: URL {
    guard
      let url = URL(string: "https://api.spotify.com/v1/me/top")
    else { fatalError("Terrible URL") }

    return url
  }

  var path: String {
    switch top {
    case .tracks:
      return "tracks"
    case .artists:
      return "artists"
    }
  }

  var method: HTTPMethod {
    return .get
  }

  var task: HTTPTask? {
    return .request
  }

  var headers: HTTPHeaders? {
    return ["Authorization" : authorization.authorizationHeader]
  }
}
