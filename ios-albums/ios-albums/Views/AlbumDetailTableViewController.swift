//
//  AlbumDetailTableViewController.swift
//  ios-albums
//
//  Created by denis cedeno on 3/11/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//
/**
 In the AlbumDetailTableViewController:

 Create a tempSongs: [Song] = [] array. This will be used to temporarily hold the songs the user adds until they tap the Save bar button item to save the album (or changes to it).
 Create an updateViews method. It should
 Take the appropriate values from the album (if it isn't nil) and place them in the corresponding text fields. You can use the .joined(separator: ...) method to combine the urls and genres into strings.
 Set the title of the view controller to the album's name or "New Album" if the album is nil.
 Set the tempSongs array to the album's array of Songs.
 Call updateViews() in the didSet property observer of the album variable, and in the viewDidLoad(). Remember to make sure the view is loaded before trying to set the values of the outlets or the app will crash.
 Adopt the SongTableViewCellDelegate protocol.
 Add the addSong method from the delegate you just adopted. In it:
 Create a Song using the createSong method in the albumController.
 Append the song to the tempSongs array
 Reload the table view
 Call tableView.scrollToRow(at: IndexPath, ...) method. You will need to manually create an IndexPath. Use 0 for the section and the count of the tempSongs for the row.
 Implement the numberOfRowsInSection method using the tempSongs array. Return the amount of items in the array plus one. This will allow there to be an empty cell for the user to add a new song to.
 Implement the cellForRowAt method. Set this table view controller as the cell's delegate.
 Implement the heightForRowAt method. Set the cell's height to something that looks good. Account for the cells whose buttons will be hidden, and the last cell whose button should be unhidden. In the screen recording, the hidden button cells' height is 100, and the last cell's height is 140.
 Finally, in the action of the "Save" bar button item:
 Using optional binding, unwrap the text from the text fields.
 If there is an album, call the update(album: ...) method, if not, call the createAlbum method using the unwrapped text, and the tempSongs array.
 Pop the view controller from the navigation controller.
 */
import UIKit

class AlbumDetailTableViewController: UITableViewController {

    var albumController: AlbumController?
    var album: Album? 
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBAction func saveButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return albumController?.albums.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController?.albums.count ?? 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
