//
//  AppDelegate.swift
//  Albums
//
//  Created by Gi Pyo Kim on 10/28/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let albumController = AlbumController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let songs: [Song] = [albumController.createSong(duration: "1:04", id: UUID(), name: "Sleepless"),
                             albumController.createSong(duration: "3:42", id: UUID(), name: "In Seoul"),
                             albumController.createSong(duration: "4:10", id: UUID(), name: "Lovedrunk")]
        albumController.createAlbum(artist: "Epik High",
                                    coverArt: [URL(string:"https://en.wikipedia.org/wiki/Sleepless_in#/media/File:Cover_of_2019_EP_Sleepless_in_by_Epik_HIgh.jpg")!],
                                    genres: ["Rap"],
                                    id: UUID(),
                                    name: "Sleepless", songs: songs)
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

