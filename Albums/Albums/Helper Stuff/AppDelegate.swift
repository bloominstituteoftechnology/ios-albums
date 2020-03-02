//
//  AppDelegate.swift
//  Albums
//
//  Created by Dennis Rudolph on 12/2/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        testEncodingExampleAlbum()
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
    
    func testDecodingExampleAlbum() {
        let url = URL(fileReferenceLiteralResourceName: "exampleAlbum.json")
        
        do {
            let data = try Data(contentsOf: url)
            let album = try JSONDecoder().decode(Album.self, from: data)
            print(album)
        } catch {
            print("Error")
        }
    }
    
    func testEncodingExampleAlbum() {
        let data = try! Data(contentsOf: URL(fileReferenceLiteralResourceName: "exampleAlbum.json"))

        do {
            let decoder = JSONDecoder()
            let album = try decoder.decode(Album.self, from: data)

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let albumData = try encoder.encode(album)

            let dataString = String(data: albumData, encoding: .utf8)!
            print(dataString)
        } catch {
            print("Encoding Error")
        }
    }

}

