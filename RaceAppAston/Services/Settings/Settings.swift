//
//  Settings.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 22.11.2023.
//

import Foundation
import UIKit

protocol SettingsProtocol {
    var difficulty: Difficulty {get set}
    func saveDifficulty()
}

final class Settings: SettingsProtocol {
    
    
    
    static let shared = Settings(cache: Cache.shared)
    private var cache: SettingsCacheProtocol
    var difficulty: Difficulty = .easy
    var hitObjectColor: UIColor = .red
    var carColor: UIColor = .blue
    private init(cache: SettingsCacheProtocol) {
        self.cache = cache
        self.difficulty = cache.getDifficulty()
        print(difficulty)
    }
    
    private func getFromUD() -> Difficulty {
        guard let rawValue = UserDefaults.standard.string(forKey: UDKeys.difficultyLVL.rawValue) else {
            return .easy
        }
        let diff = Difficulty(rawValue: rawValue) ?? .easy
        return diff
    }
    
    func saveDifficulty() {
        cache.saveDifficulty(difficulty)
    }
    
    
}




