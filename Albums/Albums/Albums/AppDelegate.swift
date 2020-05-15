//
//  AppDelegate.swift
//  Albums
//
//  Created by David Williams on 5/14/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       testDecodingExampleAlbum()
        return true
    }

    // MARK: UISceneSession Lifecycle

    
    func testDecodingExampleAlbum() {
        guard let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json") else { return }
        do {
            // This is essentially the same data that you would get back from an API
            let albumData = try Data(contentsOf: urlPath)
            let album = try JSONDecoder().decode(Album.self, from: albumData)
            print(album.name)
        } catch {
            NSLog("Error decoding test album: \(error)")
        }
    }
    
    
    
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

