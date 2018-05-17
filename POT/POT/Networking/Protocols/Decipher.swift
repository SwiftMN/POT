//
//  Decoder.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

protocol Decipher {
  static func decipher<T: Decodable>(data: Data) -> T
}
