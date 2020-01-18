//
//  SongTableViewCell.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var newSongNameTextField: UITextField!
    
    @IBOutlet weak var newSongNameLengthTextField: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    
    
    //MARK: Preperties
    
    var song: Song? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SongTableViewCellDelegate?
    
    //MARK: Lifecycle Methods
    
    //MARK: Actions
    
    @IBAction func addTapped(_ sender: Any) {
        guard let title = newSongNameTextField.text,
            let duration = newSongNameLengthTextField.text else {return}
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    
    //MARK: Functions
    
    func updateViews() {
        if let song = song {
            addSongButton.isHidden = true
            
            newSongNameLengthTextField.text = song.name
            newSongNameLengthTextField.text = song.duration
        }
    }
    
    override func prepareForReuse() {
        newSongNameTextField.text = ""
        newSongNameLengthTextField.text = ""
    }
}

//MARK: Protocol

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}
