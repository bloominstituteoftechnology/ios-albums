//
//  TableViewCell.swift
//  albums
//
//  Created by Lambda_School_Loaner_34 on 2/18/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    //var song: Song?
    
    //MARK: - Outlets
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBAction func addSong(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateViews() {
        
    }
    
    

}
