//
//  SongTableViewCell.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/11/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

// create delegate
protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {

    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    // set delegate
    weak var delegate: SongTableViewCellDelegate?
    
    
    // IB Outlets
    @IBOutlet weak var songTitleTxtField: UITextField!
    @IBOutlet weak var songDurationTxtField: UITextField!
    @IBOutlet weak var addSongBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configure View
    func updateViews() {
        guard let song = song else { return }
        addSongBtn.isHidden = true
        songTitleTxtField.text = song.name
        songDurationTxtField.text = song.duration
        
    }
    
    override func prepareForReuse() {
        addSongBtn.isHidden = false
        songTitleTxtField.text = ""
        songDurationTxtField.text = "0:00"
    }
    

    //IB actions
    
    @IBAction func addSongBtnWasPressed(_ sender: Any) {
        guard let title = songTitleTxtField.text,
            let duration = songDurationTxtField.text,
            !duration.isEmpty,
            !title.isEmpty else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
    
    
}

 
