//
//  TracksApi.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

struct TracksApi {
  let authorization: Authorization
  let top: Top
  let id: String
}

extension TracksApi: Endpoint {
  var baseURL: URL {
    guard
      let url = URL(string: "https://api.spotify.com/v1/artists")
      else { fatalError("Terrible URL") }

    return url
  }

  var path: String {
    return "\(id)/top-tracks"
  }

  var method: HTTPMethod {
    return .get
  }

  var task: HTTPTask? {
    return .requestQueryParameters(parameters: ["country" : "US"])
  }

  var headers: HTTPHeaders? {
    return ["Authorization" : authorization.authorizationHeader]
  }
}
