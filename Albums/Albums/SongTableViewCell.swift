//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jocelyn Stuart on 2/18/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var delegate: SongTableViewCellDelegate?
    
    var song: Song?
    
    var album: Album?
    
    func updateViews() {
        
        if let song = song {
            titleTextField.text = song.songs.keys.first
            durationTextField.text = song.songs.values.first
            addSong.alpha = 0
        }
    }
    
    override func prepareForReuse() {
        titleTextField.text = ""
        durationTextField.text = ""
        addSong.alpha = 1
        
    }
    @IBOutlet weak var addSong: UIButton!
    
    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, let duration = durationTextField.text else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    
    

}
