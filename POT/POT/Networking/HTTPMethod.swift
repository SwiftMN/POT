//
//  HTTPMethod.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

enum HTTPMethod : String, CustomStringConvertible {
  case get = "GET"
  case post = "POST"

  var description: String {
    return self.rawValue
  }
}
