//
//  AppDelegate.swift
//  Albums
//
//  Created by Nathanael Youngren on 2/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let thankUNextSongs = [Song(duration: "3:32", name: "imagine"), Song(duration: "2:52", name: "needy"), Song(duration: "3:29", name: "fake smile")]
        
        AlbumController().createAlbum(artist: "Ariana Grande", coverArt: URL(string: "https://upload.wikimedia.org/wikipedia/en/d/dd/Thank_U%2C_Next_album_cover.png"), genres: "Pop", name: "thank u, next", songs: thankUNextSongs)
        return true
    }


}

