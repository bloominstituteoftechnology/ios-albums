//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Clayton Watkins on 5/14/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - IBActions
    @IBAction func addSongTapped(_ sender: Any) {
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
