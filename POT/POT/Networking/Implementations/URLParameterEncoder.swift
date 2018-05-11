//
//  URLParameterEncoder.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
  static func encode(request: inout URLRequest, with parameters: Parameters) throws {
    guard
      let url = request.url
    else { throw HTTPError.missingURL }

    // Encode Parameters if present
    if var components = URLComponents(url: url, resolvingAgainstBaseURL: false), parameters.isEmpty == false {
      var queries = [URLQueryItem]()
      parameters.forEach {
        let value = "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let query = URLQueryItem(name: $0.key, value: value)
        queries.append(query)
      }

      // Set the new url
      components.queryItems = queries
      request.url = components.url
    }
  }
}
