//
//  SongTableViewCell.swift
//  ios-albums
//
//  Created by Joseph Rogers on 3/9/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
      //MARK: - Outlets
    
    @IBOutlet weak var songTitleTxtField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    
    
    
    //MARK: - Properties
    
    //MARK: - Actions
    

    @IBAction func addSongTapped(_ sender: Any) {
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
