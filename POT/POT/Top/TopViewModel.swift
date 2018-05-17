//
//  TopViewModel.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation
import Swinject

final class TopViewModel: NSObject {

  private let authorization: Authorization
  private let service: NetworkService
  private let api: TopApi

  @objc dynamic var artists = [Artist]()

  init(container: Container) {
    guard
      let auth = container.resolve(Authorization.self),
      let service = container.resolve(NetworkService.self)
    else { fatalError("Need Authorization & Service") }

    authorization = auth
    self.service = service
    api = TopApi(authorization: authorization, top: .artists)
  }

  func fetchTopArtists() {
    service.request(endpoint: api) { [weak self] (data, response, error) in
      if let data = data {
        let top: TopArtists = JSONDecipher.decipher(data: data)
        self?.artists = top.items
      }
    }
  }
}
