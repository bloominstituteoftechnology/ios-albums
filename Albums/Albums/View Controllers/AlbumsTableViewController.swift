//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Hunter Oppel on 4/9/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private lazy var dataSource = makeDataSource()
    var albumController: AlbumController?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumController?.getAlbumList(completion: { result in
            switch result {
            case .success(_):
                self.tableView.reloadData()
            case .failure(_):
                print("Could not load albums.")
            }
        })
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbumDetail" {
            guard let detailVC = segue.destination as? AlbumDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            detailVC.albumController = albumController
            detailVC.album = albumController?.albums[indexPath.row]
        } else if segue.identifier == "AddAlbum" {
            guard let detailVC = segue.destination as? AlbumDetailTableViewController else { return }
            
            detailVC.albumController = albumController
        }
    }

}

extension AlbumsTableViewController {
    enum Section {
        case main
    }
    
    func makeDataSource() -> UITableViewDiffableDataSource<Section, String> {
        UITableViewDiffableDataSource(tableView: tableView) { tableview, indexPath, name in
            let cell = tableview.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
            
            cell.textLabel?.text = self.albumController?.albums[indexPath.row].name
            cell.detailTextLabel?.text = self.albumController?.albums[indexPath.row].artist
            
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
