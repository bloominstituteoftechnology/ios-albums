//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Joel Groomer on 10/30/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: UITableViewController {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var txtSongTitle: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    @IBOutlet weak var btnAddSong: UIButton!
    
    var song: Song? { didSet { updateViews() } }
    weak var delegate: SongTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let song = song else { return }
        txtSongTitle.text = song.title
        txtDuration.text = song.duration
        btnAddSong.isHidden = true
    }
    
    override func prepareForReuse() {
        txtSongTitle.text = ""
        txtDuration.text = ""
        btnAddSong.isHidden = false
    }

    @IBAction func addSongTapped(_ sender: Any) {
        guard let title = txtSongTitle.text, let duration = txtDuration.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
}
