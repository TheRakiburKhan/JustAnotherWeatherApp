//
//  SceneDelegate.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let currentWindow = (scene as? UIWindowScene) else { return }
        
        if #available(iOS 15.0, *) {
            window = currentWindow.keyWindow
        } else {
            window = currentWindow.windows.first?.window
        }
        
        window?.overrideUserInterfaceStyle = .light
        
        SCENEDELEGATE = self
    }
}
