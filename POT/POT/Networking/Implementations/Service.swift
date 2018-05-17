//
//  Service.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

class Service: NetworkService {

  private var task: URLSessionTask?

  func request(endpoint: Endpoint, completion: @escaping NetworkServiceCompletion) {
    let request = buildRequest(endpoint: endpoint)
    task = session.dataTask(with: request, completionHandler: { (data, response, error) in
      completion(data, response, error)
    })

    task?.resume()
  }

  func stop() {
    task?.cancel()
  }

  private func buildRequest(endpoint: Endpoint) -> URLRequest {
    let fullURL = endpoint.baseURL.appendingPathComponent(endpoint.path)
    var request = URLRequest(url: fullURL,
                             cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                             timeoutInterval: 5.0)
    request.httpMethod = "\(endpoint.method)"

    if let task = endpoint.task {
      switch task {
      case .request :
        print("Request")
      case .requestQueryParameters(let params) :
        print("Request w/ Query")
        if let params = params {
          do {
            try URLParameterEncoder.encode(request: &request, with: params)
          } catch {
            print("Error encoding in Service")
          }
        }
      }
    }

    return request
  }
}
