//
//  JSONParameterEncoder.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
  static func encode(request: inout URLRequest, with parameters: Parameters) throws {
    guard
      let _ = request.url
    else { throw HTTPError.missingURL }

    let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    request.httpBody = data
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  }
}
