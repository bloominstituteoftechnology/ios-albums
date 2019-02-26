//
//  AlbumsTableViewController.swift
//  iOSAlbums
//
//  Created by Angel Buenrostro on 2/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let albumController = albumController else {
            self.albumController = AlbumController()
            
            DispatchQueue.main.async {
                self.albumController!.getAlbums {_ in 
                    self.tableView.reloadData()
                }
                
                print("num of albums: \(self.albumController!.albums.count)")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.albumController!.getAlbums { (error) in
                print("Number of albums: \(self.albumController!.albums)")
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
            print("num of albums: \(self.albumController!.albums.count)")
        }
        
        
        func viewDidAppear() {
            self.tableView.reloadData()
        }
        
//        albumController.testDecodingExampleAlbum()
//        albumController.testEncodingExampleAlbum()
//        let songs = [
//            albumController.createSong(name: "Slow Burn", duration: "4:06", id: UUID()),
//            albumController.createSong(name: "Lonely Weekend", duration: "3:47", id: UUID()),
//            albumController.createSong(name: "Butterflies", duration: "3:39", id: UUID()),
//            albumController.createSong(name: "Oh, What A World", duration: "4:01", id: UUID()),
//            albumController.createSong(name: "Mother", duration: "1:18", id: UUID()),
//            albumController.createSong(name: "Love Is A Wild Thing", duration: "4:16", id: UUID()),
//            albumController.createSong(name: "Space Cowboy", duration: "3:36", id: UUID()),
//            albumController.createSong(name: "Happy & Sad", duration: "4:03", id: UUID()),
//            albumController.createSong(name: "Velvet Elvis", duration: "2:34", id: UUID()),
//            albumController.createSong(name: "Wonder Woman", duration: "4:00", id: UUID()),
//            albumController.createSong(name: "High Horse", duration: "3:34", id: UUID()),
//            albumController.createSong(name: "Golden Hour", duration: "3:18", id: UUID()),
//            albumController.createSong(name: "Rainbow", duration: "3:34", id: UUID())
//
//
//        ]
//        let url = Bundle.main.url(forResource: "goldenHourAlbumArt", withExtension: "jpg")!
//        albumController.createAlbum(artist: "Kacey Musgraves", coverArt: [url], genres: ["Country", "Contemporary"], id: UUID(), name: "Golden Hour", songs: songs)
//
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.albumController!.albums.count)
        print(albumController?.albums.count)
        return self.albumController!.albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let album = albumController!.albums[indexPath.row]
        cell.textLabel!.text = album.name
        cell.detailTextLabel!.text = album.artist
        // Configure the cell...
        print("This is the cell: \(cell)")
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
