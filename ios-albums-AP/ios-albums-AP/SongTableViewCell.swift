//
//  SongTableViewCell.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

// SongCell
import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addButtonLabel: UIButton!
    
    // weak var error?
    var delegate: SongTableViewCellDelegate?
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        print("updateViews")
        
        // Detail
        if let song = self.song {
            print("Detail")
            songTextField.text = song.name
            durationTextField.text = song.duration
            addButtonLabel.isHidden = true
        }
        else {
            print("Add")
            addButtonLabel.isHidden = false
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("addbutton tapped")
        
        guard let songTitle = songTextField.text, let duration = durationTextField.text, !songTitle.isEmpty, !duration.isEmpty else {return}
        delegate?.addSong(with: songTitle, duration: duration)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
