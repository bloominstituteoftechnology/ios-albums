//
//  AppDelegate.swift
//  Albums
//
//  Created by David Wright on 3/11/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let ac = AlbumController()
//        ac.testDecodingExampleAlbum()
//        ac.testEncodingExampleAlbum()
        let song1 = ac.createSong(title: "Song 1", duration: "1:00", id: "1")
        let song2 = ac.createSong(title: "Song 2", duration: "2:00", id: "2")
        let song3 = ac.createSong(title: "Song 3", duration: "3:00", id: "3")
        let songs = [song1, song2, song3]
        ac.createAlbum(albumName: "Test Album Name",
                       artist: "Test Artist",
                       songs: songs,
                       coverArt: [URL(fileURLWithPath: "http://blog.iso50.com/wp-content/uploads/2013/12/Awake-450.jpg")],
                       genres: ["test genre"],
                       id: "1")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

