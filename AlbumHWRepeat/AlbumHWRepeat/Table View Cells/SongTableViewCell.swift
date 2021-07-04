//
//  SongTableViewCell.swift
//  AlbumHWRepeat
//
//  Created by Michael Flowers on 6/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    weak var delegate: SongTableViewCellDelegate?
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: IBOutlets
    @IBOutlet weak var songTitleTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    @IBOutlet weak var addSongProperties: UIButton!
    
    //MARK: IBAction
    @IBAction func addSong(_ sender: UIButton) {
        guard let title = songTitleTF.text, !title.isEmpty, let legnth = durationTF.text, !legnth.isEmpty else { print("Error with deleget function"); return }
        
    delegate?.addSong(with: title, duration: legnth)
    }
    
    override func prepareForReuse() {
        songTitleTF.text = ""
        durationTF.text = ""
        addSongProperties.isHidden = false
    }
    
    func updateViews(){
        guard let passedInSong = song else { print("Error: song not passedIn"); return }
        songTitleTF.text = passedInSong.name
        durationTF.text = passedInSong.duration
        addSongProperties.isHidden = true
    }
}
