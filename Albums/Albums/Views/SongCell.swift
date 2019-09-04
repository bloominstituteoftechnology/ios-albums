//
//  SongCell.swift
//  Albums
//
//  Created by Jeffrey Santana on 9/3/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

protocol SongCellDelegate {
	func newSongAdded()
}

class SongCell: UITableViewCell {

	//MARK: - IBOutlets
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var durationTextField: UITextField!
	
	//MARK: - Properties
	
	
	//MARK: - IBActions
	
	@IBAction func addSongBtnTapped(_ sender: Any) {
		
	}
	
	//MARK: - Helpers
	
	
}
