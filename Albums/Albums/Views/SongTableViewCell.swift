//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var song: Songs?
    var delegate: SongTableViewCellDelegate?

    
    // MARK: - Outlets
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func addSong(_ sender: UIButton) {
        guard let title = songTitle.text,
            let duration = songDuration.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    // MARK: - Methods
    
    func updateViews() {
        
        if let song = song {
            songTitle.text = song.name
            songDuration.text = song.duration
            addSongButton.isHidden = true
        }
        
        addSongButton.layer.cornerRadius = 7.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        songTitle.text = ""
        songDuration.text = ""
        addSongButton.isHidden = false
    }
}

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}
