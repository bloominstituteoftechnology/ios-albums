//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Ilgar Ilyasov on 10/8/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var song: Song? { didSet { updateViews() }}
    weak var delegate: SongTableViewCellDelegate?
    
    // MARK: - Outlets

    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitle.text,
            let duration = songDuration.text else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    // MARK: - Update
    
    func updateViews() {
        if let song = song {
            songTitle.text = song.name
            songDuration.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    // MARK: - Reuse the cell
    override func prepareForReuse() {
        super.prepareForReuse()
        songTitle.text = ""
        songDuration.text = ""
        addSongButton.isHidden = false
    }
}
