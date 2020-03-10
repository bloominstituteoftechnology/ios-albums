//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by Joseph Rogers on 3/9/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    
    
      //MARK: - Outlets
    
    @IBOutlet weak var songTitleTxtField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
        //MARK: - Properties
    
    var song: Song? {
          didSet {
              updateViews()
          }
      }
      weak var delegate: SongTableViewCellDelegate?
      
      func updateViews() {
          if let song = self.song {
              self.songTitleTxtField.text = song.name
              self.songDurationTextField.text = song.duration
              self.addButton.isHidden = true
          }
      }
      
      override func prepareForReuse() {
          super.prepareForReuse()
          self.songTitleTxtField.text = nil
          self.songDurationTextField.text = nil
          self.addButton.isHidden = false
      }
      

    
    //MARK: - Actions
    

    @IBAction func addSongTapped(_ sender: Any) {
        guard let title = self.songTitleTxtField.text,
                   let duration = self.songDurationTextField.text else { return }
               delegate?.addSong(with: title, duration: duration)
    }


}
