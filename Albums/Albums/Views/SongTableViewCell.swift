//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Ciara Beitel on 10/1/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    var song: Song?
    var delegate: SongTableViewCellDelegate?
    
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
    @IBOutlet weak var addSong: UIButton!
    
       
    @IBAction func addSongButton(_ sender: UIButton) {
        guard let songTitle = songTitle.text,
            let songDuration = songDuration.text else { return }
        self.delegate?.addSong(with: songTitle, duration: songDuration)
    }
    
    func updateViews() {
        if var song = song {
            let songName = SongName(title: songTitle.text!)
            song.name = songName
            let tempDuration = SongDuration(duration: songDuration.text!)
            song.duration = tempDuration
            addSong.isHidden = true
        } else {
            addSong.isHidden = false
        }
    }
    
    override func prepareForReuse() {
        songTitle.text?.removeAll()
        songDuration.text?.removeAll()
        addSong.isHidden = false
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}
