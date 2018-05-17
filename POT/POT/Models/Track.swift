//
//  Track.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

class Track: NSObject, Codable {
  let id: String
  let name: String
  let preview: String

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case preview = "preview_url"
  }

  init(id: String, name: String, preview: String) {
    self.id = id
    self.name = name
    self.preview = preview
  }
}

class TopTracks : NSObject, Codable {
  let tracks: [Track]

  init(tracks: [Track]) {
    self.tracks = tracks
  }
}
