//
//  RaceScreenPresenter.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation

protocol RaceScreenPresenterProtocol {
    var player: PlayerModel { get }
    func getDuration() -> TimeInterval
    func tryAgain()
    func showAlert()
    func saveRecord(record: PlayerModel)
    var score: Int { get  set }
}

final class RaceScreenPresenter: RaceScreenPresenterProtocol {
    
    
    var score: Int = 0
    
    weak var view: RaceScreenProtocol?
    var settings: SettingsProtocol
    var player: PlayerModel
    var cache: RecordCacheProtocol
    init(view: RaceScreenProtocol?, settings: SettingsProtocol, player: PlayerModel, cache: RecordCacheProtocol) {
        self.view = view
        self.settings = settings
        self.player = player
        self.cache = cache
    }
    
    func getDuration() -> TimeInterval {
        switch settings.difficulty {
        case .hard:
            return DifficultyTime.hard
        case .medium:
            return DifficultyTime.medium
        case .easy:
            return DifficultyTime.easy
        }
    }
    
    func showAlert() {
        view?.showAlert()
    }
    
    func tryAgain() {
        view?.tryAgain()
    }
    
    func saveRecord(record: PlayerModel) {
        player.score = score
        cache.addToCache(record: player)
    }
}

private extension RaceScreenPresenter {
    enum DifficultyTime {
        static let easy: TimeInterval = 7
        static let medium: TimeInterval = 5
        static let hard: TimeInterval = 3
    }
}


struct User: Codable {
    let name: String
}

func someFF() {
    let user = User(name: "a")
    let encoder = JSONEncoder()
    let data = try? encoder.encode(user)
    
    
}
