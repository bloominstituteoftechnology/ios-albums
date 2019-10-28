//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Jesse Ruiz on 10/28/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - Outlets
    @IBOutlet weak var songTitle: UITextField!
    @IBOutlet weak var songDuration: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func addSong(_ sender: UIButton) {
        
    }
    
    // MARK: - Methods
    
    func updateViews() {
        
        addSongButton.layer.cornerRadius = 7.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
