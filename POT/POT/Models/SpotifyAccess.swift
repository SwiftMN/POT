//
//  SpotifyAccess.swift
//  POT
//
//  Created by Adam Ahrens on 5/16/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

final class SpotifyAccess {
  let key: String
  let secret: String

  init(key: String, secret: String) {
    self.key = key
    self.secret = secret
  }
}
