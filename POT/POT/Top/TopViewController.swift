//
//  TopViewController.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {
  @objc private var viewModel: TopViewModel!

  @IBOutlet weak var tableView: UITableView!
  private var observers = [NSKeyValueObservation]()

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel = TopViewModel(container: Injector.shared.container)

    setupObservations()

    viewModel.fetchTopArtists()
  }

  private func setupObservations() {
    observers = [
      viewModel.observe(\.artists, options: [.new]) { [weak self] object, change in
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      }
    ]
  }
}

extension TopViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.artists.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let artist = viewModel.artists[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCell", for: indexPath) as! ArtistTableViewCell
    cell.artistNameLabel.text = artist.name
    return cell
  }
}
