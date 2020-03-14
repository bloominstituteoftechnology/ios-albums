//
//  AppDelegate.swift
//  Albums
//
//  Created by Jessie Ann Griffin on 3/10/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let albumController = AlbumController()
        albumController.testDecodingExampleAlbum()
        albumController.testEncodingExampleAlbum()
        albumController.createAlbum(artist: "Weezer",
                                    coverArt: [URL(string: "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png")!],
                                    genres: ["Alternatjve"],
                                    id: "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
                                    name: "Weezer (The Blue Album)",
                                    songs: [])
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

