//
//  Injector.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation
import Swinject

final class Injector {
  static let shared = Injector()
  let container = Container()
  private init() { }
}
