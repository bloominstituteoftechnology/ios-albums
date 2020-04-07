//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(withTitle title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    var song: Song? { didSet { updateViews() }}
    weak var delegate: SongTableViewCellDelegate?

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func addSongTapped(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty,
            let duration = durationTextField.text, !duration.isEmpty else { return }
        delegate?.addSong(withTitle: title, duration: duration)
    }
    
    // MARK: - Private
    
    private func updateViews() {
        guard let song = song else { return }
        titleTextField.text = song.title
        titleTextField.isUserInteractionEnabled = false
        durationTextField.text = song.duration
        durationTextField.isUserInteractionEnabled = false
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        titleTextField.text = nil
        titleTextField.isUserInteractionEnabled = true
        durationTextField.text = nil
        durationTextField.isUserInteractionEnabled = true
        addSongButton.isHidden = false
    }
}
