//
//  AlbumController.swift
//  ios-albums-AP
//
//  Created by Jorge Alvarez on 2/10/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

// Data(contentsOf: "exampleAlbum.json")

/*
// !!! THIS IS BAD WAY TO DO IT DON"T DO IN YOUR APPS
let url = URL(string: "https://swapi.co/api/people/1/")!
let data = try! Data(contentsOf: url)

let decoder = JSONDecoder()
let luke = try! decoder.decode(Person.self, from: data)

print(luke)

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted]
let lukeData = try! encoder.encode(luke)

let lukeString = String(data: lukeData, encoding: .utf8)
print(lukeString!)
*/

class AlbumController {
    
    // MARK: - Properties
    
    // Data source
    var albums: [Album] = []
    // Firebase Link
    let baseURL = URL(string: "https://albumsap-a518f.firebaseio.com/")!
    
    typealias CompletionHanlder = (Error?) -> Void
    // MARK: - Networking
    
    func testDecodingExampleAlbum() {
        print("TEST DECODING CALLED")
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
            
        do {
            let album = try decoder.decode(Album.self, from: data)
            print("This is the DECODING album \(album)")
        } catch {
            NSLog("Error decoding album")
        }
    }
    
    func testEncodingExampleAlbum() {
        print("TEST ENCODING CALLED")
        
        let url = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]
        
        do {
            let album = try decoder.decode(Album.self, from: data)
            let encodedAlbum = try encoder.encode(album)
            self.albums.append(album)
            print("This is the DECODED album \n\(album)")
            print("\n \n")
            print("This is the ENCODED album: \n")
            let albumString = String(data: encodedAlbum, encoding: .utf8)
            print(albumString!)
        } catch {
            NSLog("Error decoding/encoding album")
        }
    }
    
    /// Should have a completion handler that takes in an optional Error. This function should perform a URLSessionDataTask that fetches the albums from the baseURL, decode them, and sets the albums array to the decoded albums. You should decode the JSON data as [String: Album].self here
    func getAlbums(completion: @escaping (Error?) -> Void) {
        print("called getAlbums")
        
        let getAlbumsURL = baseURL.appendingPathExtension("json")
        let request = URLRequest(url: getAlbumsURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("Error fetching albums: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            guard let data = data else {
                print("No data returned by data task")
                DispatchQueue.main.async {
                    completion(NSError())
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                
                let albums = Array(try decoder.decode([String: Album].self, from: data).values)
                self.albums = albums
                DispatchQueue.main.async {
                    completion(nil)
                }
            } catch {
                print("Error decoding or storing albums in getAlbums: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
            }
            
        }.resume()
    }
    
    /// A function called put(album: Album). This should use a URLSessionDataTask to PUT the album passed into the function to the API. Add the album's identifier to the base URL so it gets put in a unique location in the API.
    func put(album: Album, completion: @escaping CompletionHanlder = { _ in }) {
        print("called put(album)")
        
        let uuid = UUID().uuidString
        
        let requestURL = baseURL.appendingPathComponent("\(uuid)").appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        var testAlbum = album
        testAlbum.id = uuid
        
        let encoder = JSONEncoder()
        
        do {
            
            let encodedAlbum = try encoder.encode(testAlbum)
            request.httpBody = encodedAlbum
        } catch {
            NSLog("Error encoding album \(album): \(error)")
            DispatchQueue.main.async {
                completion(error)
            }
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error in sending album to server \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
            
    /// A function called createAlbum. It should take in the necessary properties as parameters in order to initialize a new Album. Create an Album from the method parameters, then append it to the albums array. Then call the put(album: Album) method so the new Album gets saved to the API.
    func createAlbum() {
        print("called createAlbum")
    }
    
    /// A function called createSong. It should take in the necessary properties as parameters to be able to initialize a Song. The function should return a Song. In the method, simply initialize a new song from the method parameters and return it.
    func createSong() {
        print("called createSong")
    }
    
    /// A  function called update. This should take in an Album and a parameter for each of the Album object's properties that can be changed (This should be every property). Update the values of the Album parameter, then send those changes to the API by calling the put(album: Album) method.
    func update() {
        print("called update")
    }
}
    // ADD APPENDINGPATHEXTENSION

    /*
     INSTRUCTIONS
     Part 2 - Manual Codable Conformance

     The whole purpose of this project is to help you understand how Codable works under the hood when it automatically synthesizes conformance to the protocol, as well as giving you the ability to implement it yourself when necessary.

         Create a new Swift file called "Album.swift". Create a model object called Album.
         Using the JSON provided in the "ExampleAlbum.json" file, parse the JSON to figure out what properties your Album model should have.
             NOTE: Create a second model object called Song for the array of Songs. Your Song should have 3 properties.
             NOTE: You must have a property for every value the JSON contains. There should be 6 properties.
         Adopt just Decodable on both model objects for now. Starting with Song, implement the required init(from decoder: Decoder) throws initializer.
             The goal of implementing this initializer yourself is to avoid using nested structs, and keeping your model object "flat".
             Use the example JSON to figure out how to decode it into your model objects.
             Assume that all properties in the model objects are not optional and are variables.
         Add the "exampleAlbum.json" file to your project. Make sure you check "Copy file(s) if needed", and add it to your target.
         Create a new Swift file called "AlbumController.swift". Create an AlbumController class.
         Create a function in the AlbumController called testDecodingExampleAlbum(). This should:
             Get the JSON data from the "exampleAlbum.json" file. (Data(contentsOf: URL))
             Try to decode the JSON using JSONDecoder just like you would if you got this data from an API.
             Check for errors. This is important because it will help you make sure you've correctly implemented the init(from decoder: Decoder) throws initializer in your model objects by giving you an error about what you have potentially done wrong.
         Run this function in the AppDelegate. Make sure you don't get any errors when decoding the example JSON before you move on.
         Back in the "Album.swift" file, now adopt Codable in both model objects.
         Implement the encode(to encoder: Encoder) throws function. This function should encode the JSON back into its original nested state (i.e. the encoded JSON should match the structure of the example JSON exactly).
         Create a function in the AlbumController called testEncodingExampleAlbum(). Copy and paste the code from the testDecodingExampleAlbum() method. Then simply try encoding the newly decoded Album. Again, check for errors to make sure you're encoding correctly.

     Part 3 - AlbumController

     Now you will add the functionality to fetch Albums from and send them to an API. In the AlbumController, create and the following:

         An albums: [Album] variable that will be the data source for the application
         A baseURL: URL property. Create or use an existing Firebase Database for the base URL.
         A function called getAlbums. It should have a completion handler that takes in an optional Error. This function should perform a URLSessionDataTask that fetches the albums from the baseURL, decodes them, and sets the albums array to the decoded albums. Note: You should decode the JSON data as [String: Album].self here.
         A function called put(album: Album). This should use a URLSessionDataTask to PUT the album passed into the function to the API. Add the album's identifier to the base URL so it gets put in a unique location in the API.
         A function called createAlbum. It should take in the necessary properties as parameters in order to initialize a new Album. Create an Album from the method parameters, then append it to the albums array. Then call the put(album: Album) method so the new Album gets saved to the API.
         A function called createSong. It should take in the necessary properties as parameters to be able to initialize a Song. The function should return a Song. In the method, simply initialize a new song from the method parameters and return it.
         A function called update. This should take in an Album and a parameter for each of the Album object's properties that can be changed (This should be every property). Update the values of the Album parameter, then send those changes to the API by calling the put(album: Album) method.

     Test the createAlbum method by either using the example JSON or passing in your own Album information. Make sure it gets sent to the API, and in the correct structure.
     Part 4 - Wiring Up The Views

     In the AlbumsTableViewController:

         Create an albumController: AlbumController? variable.
         In the viewDidLoad, call the getAlbums method of the albumController. Reload the table view in its completion closure.
         Implement the required UITableViewDataSource methods. The table view should display the albums in the albumController's albums array. The cells should show the album's name and artist.
         Go to the AlbumDetailTableViewController. Add the following:
             An albumController: AlbumController? variable.
             An album: Album? variable.
         Back in the AlbumsTableViewController, implement the prepare(for segue: ...) method. If the segue is triggered from the bar button item, it should pass the albumController. If it's triggered from tapping a cell, it should pass the albumController and the Album that corresponds to the cell.

     In the SongTableViewCell:

         Create a song: Song? variable.
         Create an updateViews method. It should:
             Check if the song exists. If it does, set the text fields' text to the corresponding values of the Song.
             If the song exists, also hide the button.
         Implement the prepareForReuse() method. Clear the text fields' text, and unhide the button.
         Create a class protocol above or below the SongTableViewCell class called SongTableViewCellDelegate. It should have a single function: func addSong(with title: String, duration: String).
         Create a weak var delegate: SongTableViewCellDelegate?.
         In the action of the bar button item, call delegate?.addSong(with title: ...). Pass in the unwrapped text from the text fields for the parameters to the method.

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

