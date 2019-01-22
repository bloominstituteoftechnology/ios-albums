//
//  AlbumsTableViewController.swift
//  albums
//
//  Created by Benjamin Hakes on 1/21/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumsTableViewCell else { fatalError("Failed to dequeue reusaable cell as \"albumCell\"")}

        // Configure the cell...

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
