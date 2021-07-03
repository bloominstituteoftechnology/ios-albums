//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Michael Stoffer on 7/22/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets and Properties
    @IBOutlet var songTitle: UITextField!
    @IBOutlet var songDuration: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var song: Song? {
        didSet {
            self.updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?
    
    private func updateViews() {
        if let song = self.song {
            self.songTitle.text = song.name
            self.songDuration.text = song.duration
            self.addButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        self.songTitle.text = nil
        self.songDuration.text = nil
        self.addButton.isHidden = false
    }
    
    // MARK: - IBActions and Methods
    @IBAction func addSong(_ sender: Any) {
        guard let title = self.songTitle.text,
            let duration = self.songDuration.text else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
}
