//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Lambda_School_Loaner_259 on 4/6/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    var delegate: SongTableViewCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleTextField.text, let duration = songDurationTextField.text else { return }
        delegate?.addSong(wth: title, duration: duration)
    }
    
    // MARK: - View lifecycle
    func updateViews() {
        guard let song = song else { return }
        addSongButton.isHidden = true
        songTitleTextField.text = song.name
        songDurationTextField.text = song.duration
    }
    
    override func prepareForReuse() {
        songDurationTextField.text = ""
        songTitleTextField.text = ""
        addSongButton.isHidden = false
    }

}

protocol SongTableViewCellDelegate {
    func addSong(wth title: String, duration: String)
}
