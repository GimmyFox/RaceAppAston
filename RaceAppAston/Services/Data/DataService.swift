//
//  UDService.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 04.12.2023.
//

import Foundation

enum UDKeys: String {
    case records = "records"
    case difficultyLVL = "difficultyLVL"
    case carColor = "carColor"
    case hitObjColor = "hitObjColor"
}


protocol RecordCacheProtocol {
    func getCachedRecords() -> [PlayerModel]
    func removeCache()
    func addToCache(record: PlayerModel)
    func saveToUD()
    func getStoredRecords() -> [PlayerModel]
}

protocol SettingsCacheProtocol {
    func getDifficulty() -> Difficulty
    func saveDifficulty(_ diff: Difficulty)
}


final class Cache: RecordCacheProtocol {

    
    static let shared = Cache()
    
    private var cached: [PlayerModel] = []
    
    private init() {
        self.cached = getStoredRecords()
    }
    
    func getCachedRecords() -> [PlayerModel] {
        cached
    }
    
    func removeCache() {
        cached.removeAll()
    }
    
    func addToCache(record: PlayerModel) {
        cached.append(record)
        saveToUD()
    }
    
    func saveToUD() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(cached)
            UserDefaults.standard.set(data, forKey: UDKeys.records.rawValue)
            print("saved")
        } catch {
            print("error on saving")
        }
    }
    
    func getStoredRecords() -> [PlayerModel] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: UDKeys.records.rawValue) {
            do {
                let records = try decoder.decode([PlayerModel].self, from: data)
                return records
            } catch {
                print("error on retrieve")
                return []
            }
        } else {
            print("got no data - deleted byself or never been stored")
        }
        return []
    }
}


extension Cache: SettingsCacheProtocol {
    func getDifficulty() -> Difficulty {
        guard let rawValue = UserDefaults.standard.string(forKey: UDKeys.difficultyLVL.rawValue) else {
            
            return .easy
        }
        print("rawV: \(rawValue)")
        let diff = Difficulty(rawValue: rawValue) ?? .easy
        return diff
    }
    
    func saveDifficulty(_ diff: Difficulty) {
        UserDefaults.standard.set(diff.rawValue, forKey: UDKeys.difficultyLVL.rawValue)
    }
}
