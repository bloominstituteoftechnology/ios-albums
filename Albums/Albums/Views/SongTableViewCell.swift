//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Karen Rodriguez on 4/6/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(duration: String, title: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SongTableViewCellDelegate?

    // MARK: - Outlets
    
    @IBOutlet weak var songNameField: UITextField!
    @IBOutlet weak var songDurationField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions

    @IBAction func addSongButtonTapped(_ sender: Any) {
        
        guard let title = songNameField.text,
            !title.isEmpty,
            let duration = songDurationField.text,
            !duration.isEmpty else { return }
        
        delegate?.addSong(duration: duration, title: title)
    }
    
    // MARK: - Method
    
    private func updateViews() {
        DispatchQueue.main.async {
            if let song = self.song {
                self.addSongButton.isHidden = true
                self.songNameField.text = song.title
                self.songDurationField.text = song.duration
            }
        }
    }
    
    override func prepareForReuse() {
        addSongButton.isHidden = false
        songNameField.text = ""
        songDurationField.text = ""
    }
    
}
