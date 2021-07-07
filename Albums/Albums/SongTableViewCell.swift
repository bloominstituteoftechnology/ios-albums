//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Sergey Osipyan on 1/28/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import UIKit

class SongTableViewCellDelegate {
    
    
    func addSong(with title: String, duration: String) {
        
    }
}

class SongTableViewCell: UITableViewCell {
    
    var song: Album.Song?
    weak var delegate: SongTableViewCellDelegate?
    
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var duration: UITextField!
    @IBOutlet weak var addSong: UIButton!
    @IBAction func addSongButton(_ sender: Any) {
        if let text = songTitle.text, let durText = duration.text {
        delegate?.addSong(with: text, duration: durText)
    }
    }
    func updateView() {
        
        guard let song = song else { return }
        songTitle.text = song.name
        duration.text = song.duration
        addSong.isHidden = true
        
    }
    
    override func prepareForReuse() {
        songTitle.text = ""
        duration.text = ""
        addSong.isHidden = false
    }
    
}


