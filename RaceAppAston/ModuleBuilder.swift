//
//  ModuleBuilder.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation
import UIKit




protocol Builder {
    func createMainScreen() -> UIViewController
    func createRaceScreen(player: PlayerModel) -> UIViewController
    func createSettingsScreen() -> UIViewController
    func createRecordsScreen() -> UIViewController
}


final class ModuleBuilder: Builder {
    
    let settings = Settings.shared
    let cache = Cache.shared
    
    func createMainScreen() -> UIViewController {
        let view = MainScreenViewController()
        let presenter = MainScreenPresenter(view: view)
        view.presenter = presenter
        let navigation = UINavigationController(rootViewController: view)
        return navigation
    }
    
    func createRaceScreen(player: PlayerModel) -> UIViewController {
        let view = RaceScreenViewController()
        let presenter = RaceScreenPresenter(view: view, settings: settings, player: player, cache: cache)
        view.presenter = presenter
        return view
    }
    
    func createSettingsScreen() -> UIViewController {
        let view = SettingsScreenViewController()
        let presenter = SettingsScreenPresenter(view: view, settings: settings)
        view.presenter = presenter
        return view
    }
    
    func createRecordsScreen() -> UIViewController {
        let view = RecordsScreenViewController()
        let presenter = RecordsScreenPresenter(view: view, cache: cache)
        view.presenter = presenter
        return view
    }
}
