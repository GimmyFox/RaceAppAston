//
//  MainScreenPresenter.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 20.11.2023.
//

import Foundation

protocol MainScreenPresenterProtocol {
    
}

final class MainScreenPresenter {
    weak var view: MainScreenProtocol?
    
    init(view: MainScreenProtocol?) {
        self.view = view
    }
}


extension MainScreenPresenter: MainScreenPresenterProtocol {
    
}
