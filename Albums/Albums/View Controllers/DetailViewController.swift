//
//  DetailViewController.swift
//  Albums
//
//  Created by Hector Steven on 6/10/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.delegate = self
	}
	
	
	
	@IBOutlet var albumLabel: UITextField!
	@IBOutlet var artistLabel: UITextField!
	@IBOutlet var generesLabel: UITextField!
	@IBOutlet var imagesUrlsLabel: UITextField!
	@IBOutlet var tableView: UITableView!
}
