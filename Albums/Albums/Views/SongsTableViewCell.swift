//
//  SongsTableViewCell.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
    func addSong(with title: String, duration: String)
}

class SongsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    // MARK: - Properties
    
    var song: Song?
    var delegate: SongTableViewCellDelegate?
    
    // MARK: - Action Handlers
    
    @IBAction func addSong(_ sender: Any) {
        guard let title = titleTextField.text,
            title.isEmpty == false,
            let duration = lengthTextField.text,
            duration.isEmpty == false
            else { return }
        
        delegate?.addSong(with: title, duration: duration)
    }
    
    // MARK: - Functions
    
    private func updateViews() {
        guard let song = song else { return }
        
        titleTextField.text = song.name.title
        lengthTextField.text = song.duration.duration
        addSongButton.isHidden = true
    }
    
    override func prepareForReuse() {
        titleTextField.text?.removeAll()
        lengthTextField.text?.removeAll()
        addSongButton.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
