//
//  TracksViewController.swift
//  POT
//
//  Created by Adam Ahrens on 5/17/18.
//  Copyright © 2018 SwiftMN. All rights reserved.
//

import UIKit
import AVFoundation

final class TracksViewController: UIViewController {
  @objc private var viewModel: TracksViewModel!
  
  @IBOutlet weak var tableView: UITableView!
  
  private var observers = [NSKeyValueObservation]()

  private var audioPlayer: AVAudioPlayer?

  override func viewDidLoad() {
    super.viewDidLoad()

    let container = Injector.shared.container
    viewModel = TracksViewModel(container: container)

    title = "\(viewModel.artist.name) Tracks"
    
    setupObservations()

    viewModel.fetchTopTracks()
  }

  private func setupObservations() {
    observers = [
      viewModel.observe(\.tracks, options: [.new]) { [weak self] object, change in
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      }]
  }
}

extension TracksViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.tracks.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let track = viewModel.tracks[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCell", for: indexPath) as! ArtistTableViewCell
    cell.artistNameLabel.text = track.name
    return cell
  }
}

extension TracksViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let track = viewModel.tracks[indexPath.row]
    let previewURL = track.preview

    if let previous = audioPlayer, previous.isPlaying {
      previous.stop()
    }

    if let url = URL(string: previewURL) {
      try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try! AVAudioSession.sharedInstance().setActive(true)  

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
          if let d = data {
            do {
              self.audioPlayer = try AVAudioPlayer(data: d)
              self.audioPlayer?.prepareToPlay()
              self.audioPlayer?.play()
            } catch {
              print("Wheels have come off the bus. \(error)")
            }
          }
        }

        task.resume()
      }
    }
}
