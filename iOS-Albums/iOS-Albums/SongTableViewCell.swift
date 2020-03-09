//
//  SongTableViewCell.swift
//  iOS-Albums
//
//  Created by Lambda_School_Loaner_268 on 3/9/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Outlets
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var durationTF: UITextField!
    
    // MARK: - Actions
    
    @IBAction func addSongButton(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
