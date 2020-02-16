//
//  AlbumDetailTableViewController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var tempSongs: [Song] = []
    
    var albumController: AlbumController?
    var album: Album? {
        didSet {
            updateViews()
        }
    }
    
    /*
    Finally, in the action of the "Save" bar button item:
        Using optional binding, unwrap the text from the text fields.
        If there is an album, call the update(album: ...) method, if not, call the createAlbum method using the unwrapped text, and the tempSongs array.
        Pop the view controller from the navigation controller.
    */
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        print("save tapped")
        guard let albumName = albumTextField.text, let artistName = artistTextField.text, let genreName = genreTextField.text, let urlName = urlTextField.text, !albumName.isEmpty, !artistName.isEmpty, !genreName.isEmpty, !urlName.isEmpty else {return}
        
        // using the 4 fields either update or create an album
        // Detail / Update
        if let album = album {
            //albumController?.update()
        }
        // Add / Create
        else {
            //albumController?.createAlbum()
            // then add to tempSongs
            //tempSongs.append(contentsOf: <#T##Sequence#>)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        print("updateViews()")
        guard isViewLoaded else {return}
        if let album = album {
            title = album.name
            albumTextField.text = album.name
            artistTextField.text = album.artist
            genreTextField.text = album.genres.joined(separator: ", ")
            urlTextField.text = "\(album.coverArt)"
            tempSongs = album.songs
        }
        else {
            title = "New Album"
        }
                
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
//        // FOR TESTING ONLY DELETE LATER
//        guard let album = album else {return}
//        tempSongs.append(album.songs[0])
//        // FOR TESTING ONLY DELETE LATER
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempSongs.count + 1 // So there's an empty cell for the user to add a new song to
    }
    
    /*
     Implement the heightForRowAt method. Set the cell's height to something that looks good. Account for the cells whose buttons will be hidden, and the last cell whose button should be unhidden. In the screen recording, the hidden button cells' height is 100, and the last cell's height is 140.
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    /*
     Implement the cellForRowAt method. Set this table view controller as the cell's delegate.
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)

        

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

/*
 Add the addSong method from the delegate you just adopted. In it:
     Create a Song using the createSong method in the albumController.
     Append the song to the tempSongs array
     Reload the table view
     Call tableView.scrollToRow(at: IndexPath, ...) method. You will need to manually create an IndexPath. Use 0 for the section and the count of the tempSongs for the row.
 */

extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    
    func addSong(with title: String, duration: String) {
        albumController?.createSong()
        // append the newly created song to the tempSongs array
        //tempSongs.append(contentsOf: )
        tableView.reloadData()
        // change .none to something else?
        tableView.scrollToRow(at: IndexPath(row: tempSongs.count, section: 0), at: .none, animated: true)
    }
}
