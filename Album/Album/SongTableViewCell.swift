//
//  SongTableViewCell.swift
//  Album
//
//  Created by Christy Hicks on 1/21/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    // MARK: - Preperties
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?
    weak var albumController: AlbumController?
    
    // MARK: - Outlets
    @IBOutlet weak var songNameTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var saveSongButton: UIButton!
    
    
    // MARK: - View
    override func prepareForReuse() {
        songNameTextField.text = ""
        songDurationTextField.text = ""
        saveSongButton.isHidden = false
    }
    
    func updateViews() {
        if let song = song {
            saveSongButton.isHidden = true
            songNameTextField.text = song.title
            songDurationTextField.text = song.duration
        }
    }
    
    // MARK: - Actions
    
    @IBAction func saveSongTapped(_ sender: Any) {
        guard let title = songNameTextField.text,
            let duration = songDurationTextField.text else {return}
        
        delegate?.addSong(with: title, duration: duration)
        albumController?.songList.append(song!)
    }
}

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}
