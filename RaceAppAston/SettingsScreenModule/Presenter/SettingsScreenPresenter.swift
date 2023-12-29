//
//  SettingsScreenPresenter.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation


protocol SettingsScreenPresenterProtocol {
    func getInitialDifficulty() -> Difficulty
    func changeDifficulty(_ difficulty: Difficulty)
}

final class SettingsScreenPresenter {
    var settings: SettingsProtocol
    weak var view: SettingsScreenProtocol?
    
    init(view: SettingsScreenProtocol?, settings: SettingsProtocol) {
        self.settings = settings
        self.view = view
    }
    
    
    
}


extension SettingsScreenPresenter: SettingsScreenPresenterProtocol {
    func changeDifficulty(_ difficulty: Difficulty) {
        settings.difficulty = difficulty
        settings.saveDifficulty()
        view?.setupColorButton(difficulty: difficulty)
    }
    
    func getInitialDifficulty() -> Difficulty {
        settings.difficulty
    }
}
