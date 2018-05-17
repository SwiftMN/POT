//
//  Artist.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

class Artist: NSObject, Codable {
  let id: String
  let name: String

  init(id: String, name: String) {
    self.id = id
    self.name = name
  }
}

struct TopArtists : Codable {
  let href: String
  let items: [Artist]
}
