//
//  NetworkService.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

typealias NetworkServiceCompletion = (Data?, URLResponse?, Error?) -> Void

protocol NetworkService: class, Session {
  func request(endpoint: Endpoint, completion: @escaping NetworkServiceCompletion)
  func stop()
}

extension NetworkService {
  var session: URLSession {
    get { return URLSession.shared }
  }
}
