//
//  AlbumDetailsVC.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class AlbumDetailsVC: UITableViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var albumTitleTextField: UITextField!
	@IBOutlet weak var artistTextField: UITextField!
	@IBOutlet weak var genresTextField: UITextField!
	@IBOutlet weak var coverArtURLTextField: UITextField!
	
	//MARK: - Properties
	
	var album : Album? {
		didSet {
			newSongs = album?.songs ?? [Song]()
			songCount = album?.songs.count ?? 0
		}
	}
	var albumController: AlbumController?
	private var newSongs = [Song]()
	private var songCount = 0
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	//MARK: - IBActions
	
	@IBAction func saveBtnTapped(_ sender: Any) {
		guard let albumTitle = albumTitleTextField.optionalText,
			let artist = artistTextField.optionalText,
			let genres = genresTextField.optionalText?.split(separator: ",").map({String($0)}) else { return }
		
		let coverArtUrlString = coverArtURLTextField.optionalText?.split(separator: ",")
		let coverArtUrl = coverArtUrlString?.compactMap({URL(string: String($0))})
		
		let newAlbum = Album(id: album?.id, artist: artist, coverArt: coverArtUrl, genres: genres, title: albumTitle, songs: newSongs)
		
		albumController?.putAlbum(newAlbum, completion: { (result) in
			if let _ = try? result.get() {
				DispatchQueue.main.async {
					self.navigationController?.popViewController(animated: true)
				}
			}
		})
	}
	
	//MARK: - Helpers
	
	private func updateViews() {
		guard let album = album else { return }
		albumTitleTextField.text = album.title
		artistTextField.text = album.artist
		genresTextField.text = album.genres.joined(separator: ", ")
		if let coverArtUrls = album.coverArt {
			coverArtURLTextField.text = coverArtUrls.map({$0.absoluteString}).joined(separator: ", ")
		}
	}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return songCount
    }
	
//	override func numberOfSections(in tableView: UITableView) -> Int {
//		return 1
//	}
//
//	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//		return "Songs"
//	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell else { return UITableViewCell() }
		
		if indexPath.row < songCount - 1 {
			cell.song = album?.songs[indexPath.row]
		} else {
			cell.delegate = self
		}

        return cell
    }
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			self.album?.songs.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			handler(true)
		}
		
		return UISwipeActionsConfiguration(actions: [delete])
	}

}

extension AlbumDetailsVC: SongCellDelegate {
	func newSongAdded(_ newSong: Song) {
		album?.songs.append(newSong)
		tableView.reloadData()
	}
}
