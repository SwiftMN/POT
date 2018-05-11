//
//  HTTPErrors.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

enum HTTPError: Error {
  case missingParamters
  case encodingFailed
  case missingURL
}
