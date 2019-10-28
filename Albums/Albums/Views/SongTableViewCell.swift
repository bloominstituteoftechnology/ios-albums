//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Isaac Lyons on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    //MARK: Properties
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    var delegate: SongTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Methods
    
    private func updateViews() {
        if let song = song {
            titleTextField.text = song.name
            durationTextField.text = song.duration
            addSongButton.isHidden = true
        } else {
            addSongButton.isHidden = false
        }
    }
    
    override func prepareForReuse() {
        titleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    //MARK: Actions
    
    @IBAction func addSong(_ sender: UIButton) {
        guard let title = titleTextField.text,
            let duration = durationTextField.text,
            !title.isEmpty,
            !duration.isEmpty else { return }
        
        print("Adding song.")
        delegate?.addSong(with: title, duration: duration)
    }
    
}
