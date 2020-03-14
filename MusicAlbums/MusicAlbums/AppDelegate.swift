//
//  AppDelegate.swift
//  MusicAlbums
//
//  Created by Sal B Amer on 3/11/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let albumController = AlbumController()
        albumController.testDecodingExampleAlbum()
        albumController.testEncodingExample()
        let song1 = albumController.createSong(id: "1", name: "My Song 1", duration: "2:20")
        let song2 = albumController.createSong(id: "2", name: "Song 2", duration: "4:20")
        let songs = [song1, song2]
        albumController.createAlbum(id: "1212121", name: "Test Album", artist: "Test Artist", genres: ["Rock"], coverArt: [URL(fileURLWithPath: "http://google.com")], songs: songs)
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

