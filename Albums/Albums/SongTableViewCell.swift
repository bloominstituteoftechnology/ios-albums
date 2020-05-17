//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Morgan Smith on 5/14/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: AnyObject {
    func addSong(with title: String, duration: String)
}

class SongTableViewCell: UITableViewCell {
    
    var song: Song? {
           didSet {
               updateViews()
           }
       }
       
       weak var delegate: SongTableViewCellDelegate?
    
    var connection: AlbumDetailTableViewController?
    
    override func prepareForReuse() {
           songTitle.text = ""
           songDuration.text = ""
           addSong.isHidden = false
       }
    
    func updateViews() {
        if let song = song {
            addSong.isHidden = true
            songTitle.text = song.title
            songDuration.text = song.duration
        }
    }
       

    @IBOutlet weak var songTitle: UITextField!
    
    @IBOutlet weak var songDuration: UITextField!
    
    @IBOutlet weak var addSong: UIButton!
    
    @IBAction func addSong(_ sender: UIButton) {
        guard let title = songTitle.text,
                 let duration = songDuration.text else {return}
             
             delegate?.addSong(with: title, duration: duration)
             connection?.tempSongs.append(song!)
    }
    
}
