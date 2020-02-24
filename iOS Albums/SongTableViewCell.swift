//
//  SongTableViewCell.swift
//  iOS Albums
//
//  Created by Lambda_School_Loaner_201 on 1/15/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}


class SongTableViewCell: UITableViewCell {
    
    //MARK: Preperties
       
       var song: Song? {
           didSet {
               updateViews()
           }
       }
       
       weak var delegate: SongTableViewCellDelegate?
    
    override func prepareForReuse() {
        newSongNameTextField.text = ""
        newSongNameLengthTextField.text = ""
        addSongButton.isHidden = false
    }
    
    //This function allows the songs to show on the tableView.
    func updateViews() {
        if let song = song {
            addSongButton.isHidden = true
            newSongNameTextField.text = song.title
            newSongNameLengthTextField.text = song.duration
        }
    }
    
    //MARK: Actions
    
    @IBAction func addTapped(_ sender: Any) {
        guard let title = newSongNameTextField.text,
            let duration = newSongNameLengthTextField.text else {return}
        
        delegate?.addSong(with: title, duration: duration)
        
    }
    
            
    
    //MARK: Outlets
    
    @IBOutlet weak var newSongNameTextField: UITextField!
    
    @IBOutlet weak var newSongNameLengthTextField: UITextField!
    
    @IBOutlet weak var addSongButton: UIButton!
    
    
   
    
    //MARK: Lifecycle Methods
    
    
    
    //MARK: Functions
    
    
    
    
}



