//
//  SongTableViewCell.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    var song: Song?
    weak var delegate: SongTableViewCellDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        guard let title = songTitleTextField.text,
            let duration = durationTextField.text,
            !duration.isEmpty,
            !title.isEmpty else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }

    // MARK: - Private Methods

    private func updateViews() {
        if let song = song {
            songTitleTextField.text = song.title
            durationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        songTitleTextField.text = nil
        durationTextField.text = nil
        addSongButton.isHidden = false
    }

}
