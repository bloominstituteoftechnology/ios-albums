//
//  SongTableViewCell.swift
//  Album
//
//  Created by Lydia Zhang on 4/6/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

protocol songDelegate {
    func addSong(with title: String, duration: String)
}
class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
    @IBOutlet weak var addSong: UIButton!
    
    var delegate: songDelegate?
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        if let song = song {
            songTitle.text = song.name
            songDuration.text = song.duration
            addSong.isHidden  = true
        }
    }
    
    override func prepareForReuse() {
        songTitle.text = ""
        songDuration.text = ""
        addSong.isHidden = false
    }
    @IBAction func songAdded(_ sender: Any) {
        delegate?.addSong(with: songTitle.text ?? "", duration: songDuration.text ?? "")
    }
    
}
