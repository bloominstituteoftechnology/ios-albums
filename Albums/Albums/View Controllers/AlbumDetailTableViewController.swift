//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverArtTextField: UITextField!
    
    // MARK: - Properties
    
    private lazy var dataSource = makeDataSource()
    var albumController: AlbumController?
    var album: Album?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action Handlers
    
    @IBAction func save(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumDetailTableViewController {
    enum Section {
        case main
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, String> {
        UITableViewDiffableDataSource(tableView: tableView) { tableview, indexPath, name in
            let cell = tableview.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
            
            return cell
        }
    }
    
    private func updateViews() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
        //snapshot.appendItems(albums)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
