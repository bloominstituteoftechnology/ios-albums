//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//
import UIKit

class SongTableViewCell: UITableViewCell {

    var song: Song?
    
    weak var delegate: SongTableViewCellDelegate?
    
    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = durationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    func updateViews() {
        guard let song = song else { return }
        songTitleTextField.text = song.name
        durationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        songTitleTextField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
}

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}
