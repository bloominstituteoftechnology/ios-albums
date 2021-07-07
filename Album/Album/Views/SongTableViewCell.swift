//
//  SongTableViewCell.swift
//  Album
//
//  Created by Joshua Sharp on 9/30/19.
//  Copyright © 2019 Empty Bliss. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitleTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    var delegate: SongTableViewCellDelegate?
    var song: Song?{
        didSet{
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateViews() {
        if let song = song {
            addSongButton.isHidden = true
            songTitleTF.text = song.name
            durationTF.text = song.durationString
        } else {
            addSongButton.isHidden = false
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        guard   let title = songTitleTF.text, !title.isEmpty,
                let duration = durationTF.text, !duration.isEmpty
            else { return }
        delegate?.addSong(with: title, duration: duration)
        addSongButton.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
