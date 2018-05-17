//
//  TopArtists.swift
//  POTTests
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import XCTest
import Swinject

final class FakeService: NetworkService {
  func request(endpoint: Endpoint, completion: @escaping NetworkServiceCompletion) {
    // No need to do any network calls

    let json = """
                  {
                    "items" : [
                               {"id" : "3fMbdgg4jU18AjLCKBhRSm", "name" : "1"},
                               {"id" : "d3r23fdslkjdsafsdfasdf", "name" : "2"},
                               {"id" : "d3r23fdslkjdsafsdfasdf", "name" : "3"}
                              ],
                    "href" : "who cares",
                  }
               """

    let data = json.data(using: .utf8)!
    completion(data, nil, nil)
  }

  func stop() {
    // Never gonna give you up
  }
}

class TopArtistsTests: XCTestCase {

  var container = Container()

  override func setUp() {
    super.setUp()

    // Lets setup our Container that needs everything
    container = Container()

    container.register(Authorization.self) { resolver in
      return Authorization(type: "Doesnt Matter", accessToken: "Who Cares")
    }

    container.register(NetworkService.self) { resolver in
      return FakeService()
    }
  }

  func testCanGetListOfArtists() {
    let viewModel = TopViewModel(container: container)
    assert(viewModel.artists.count == 0)

    viewModel.fetchTopArtists()
    assert(viewModel.artists.count == 3)
  }
}
