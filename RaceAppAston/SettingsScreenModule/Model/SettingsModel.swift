//
//  SettingsModel.swift
//  RaceAppAston
//
//  Created by Maksim Guzeev on 28.11.2023.
//

import Foundation


struct SettingsModel {
    let difficulty: Difficulty
}


enum Difficulty: String, CaseIterable {
    case easy
    case medium
    case hard
}
