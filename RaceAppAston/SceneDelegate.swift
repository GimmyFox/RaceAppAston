//
//  SceneDelegate.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let builder = ModuleBuilder()
        let navigationController = builder.createMainScreen()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

