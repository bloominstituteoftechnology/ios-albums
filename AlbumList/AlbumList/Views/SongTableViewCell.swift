//
//  SongTableViewCell.swift
//  AlbumList
//
//  Created by Bradley Diroff on 4/6/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var durationText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func adding(_ sender: Any) {
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
