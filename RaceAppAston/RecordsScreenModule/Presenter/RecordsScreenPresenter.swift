//
//  RecordsScreenPresenter.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation


protocol RecordsScreenPresenterProtocol {
    var records: [PlayerModel] {get}
    func removeRecords()
    func getRecords()
}

final class RecordsScreenPresenter: RecordsScreenPresenterProtocol {
 
    weak var view: RecordsScreenProtocol?
    var cache: RecordCacheProtocol
    init(view: RecordsScreenProtocol?, cache: RecordCacheProtocol) {
        self.view = view
        self.cache = cache
        getRecords()
    }
    
    var records: [PlayerModel] = []
    
    func getRecords() {
        records = cache.getCachedRecords()
    }
    
    func removeRecords() {
        UserDefaults.standard.removeObject(forKey: UDKeys.records.rawValue)
        cache.removeCache()
        records = []
        view?.updateView()
    }
}

