//
//  TracksViewModel.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation
import Swinject

final class TracksViewModel: NSObject {
  private let authorization: Authorization
  private let service: NetworkService
  private let api: TracksApi

  let artist: Artist

  @objc dynamic var tracks = [Track]()

  init(container: Container) {
    guard
      let auth = container.resolve(Authorization.self),
      let service = container.resolve(NetworkService.self),
      let art = container.resolve(Artist.self)
      else { fatalError("Need Authorization & Service") }

    authorization = auth
    self.service = service
    artist = art
    api = TracksApi(authorization: authorization, top: .artists, id: artist.id)
  }

  func fetchTopTracks() {
    service.request(endpoint: api) { [weak self] (data, response, error) in
      if let data = data {
        let topTracks: TopTracks = JSONDecipher.decipher(data: data)
        self?.tracks = topTracks.tracks
      }
    }
  }
}
