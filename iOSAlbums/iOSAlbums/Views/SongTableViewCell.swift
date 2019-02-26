//
//  SongTableViewCell.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit


protocol SongTableViewCellDelegate {
    
    func addSong(with title: String, duration: String)

}



class SongTableViewCell: UITableViewCell {
    
    var delegate: SongTableViewCellDelegate?
    var song: Song?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    
    func updateViews() {
        guard let song = song else { return }
        
        songTitleLabel.text = song.name
        durationLabel.text = song.duration
        addSongButton.isEnabled = false
    }
    
    override func prepareForReuse() {
        songTitleLabel.text = ""
        durationLabel.text = ""
        addSongButton.isEnabled = true
    }

    @IBOutlet weak var songTitleLabel: UITextField!
    @IBOutlet weak var durationLabel: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleLabel.text, let duration = durationLabel.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
}
