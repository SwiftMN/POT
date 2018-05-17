//
//  Authorization.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

final class Authorization: NSObject {
  let type: String
  let accessToken: String

  var authorizationHeader: String {
    return "\(type) \(accessToken)"
  }

  init(type: String, accessToken: String) {
    self.type = type
    self.accessToken = accessToken
  }
}
