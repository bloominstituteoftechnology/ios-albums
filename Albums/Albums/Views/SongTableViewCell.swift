//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Vici Shaweddy on 10/30/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: SongTableViewCellDelegate?
    
    func updateViews() {
        if let song = self.song {
            self.titleTextField.text = song.name
            self.durationTextField.text = song.duration
            self.addButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleTextField.text = nil
        self.durationTextField.text = nil
        self.addButton.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addPressed(_ sender: Any) {
        guard let title = self.titleTextField.text,
            let duration = self.durationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
}
