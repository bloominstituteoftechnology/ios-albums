//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//
/**
 In the SongTableViewCell:

 Create a song: Song? variable.
 Create an updateViews method. It should:
 Check if the song exists. If it does, set the text fields' text to the corresponding values of the Song.
 If the song exists, also hide the button.
 Implement the prepareForReuse() method. Clear the text fields' text, and unhide the button.
 Create a class protocol above or below the SongTableViewCell class called SongTableViewCellDelegate. It should have a single function: func addSong(with title: String, duration: String).
 Create a weak var delegate: SongTableViewCellDelegate?.
 In the action of the bar button item, call delegate?.addSong(with title: ...). Pass in the unwrapped text from the text fields for the parameters to the method.
 */
import UIKit

class SongTableViewCell: UITableViewCell {


    @IBOutlet weak var songTitleTextField: UITextField!
    
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    @IBAction func addSongButtonTapped(_ sender: Any) {
    }
}
