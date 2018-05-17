//
//  Endpoint.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String : String]

protocol Endpoint {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var task: HTTPTask? { get }
  var headers: HTTPHeaders? { get }
}
