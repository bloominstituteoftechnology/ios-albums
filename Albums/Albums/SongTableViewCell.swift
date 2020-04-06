//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Shawn Gee on 4/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
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
    }
    
    // MARK: - Private
    
    private func updateViews() {
        guard let song = song else { return }
        titleTextField.text = song.title
        durationTextField.text = song.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        titleTextField.text = nil
        durationTextField.text = nil
        addSongButton.isHidden = false
    }
}
