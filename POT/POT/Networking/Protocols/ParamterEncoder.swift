//
//  ParamterEncoder.swift
//  POT
//
//  Created by Adam Ahrens on 5/11/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import Foundation

typealias Parameters = [String:Any]

protocol ParameterEncoder {
  static func encode(request: inout URLRequest, with parameters: Parameters) throws
}
