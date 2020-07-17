//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Gladymir Philippe on 7/16/20.
//  Copyright © 2020 Gladymir Philippe. All rights reserved.
//

import UIKit


protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}


class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var songTitleLabel: UITextField!
    @IBOutlet weak var durationLabel: UITextField!
    @IBOutlet weak var songButton: UIButton!
    
    var delegate: SongTableViewCellDelegate?
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func addSongButton(_ sender: Any) {
        guard let title = songTitleLabel.text, let duration = durationLabel.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   private func updateViews() {
        guard let song = song else { return }
        
        songTitleLabel.text = song.name
        durationLabel.text = song.duration
        songButton.isHidden = true
        
    }

    override func prepareForReuse() {
        songTitleLabel.text = ""
        durationLabel.text = ""
        songButton.isHidden = false
    }
}
