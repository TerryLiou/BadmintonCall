//
//  GameModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import Foundation

struct GameModel {
    init(gameDuration: TimeInterval, courtCount: Int) {
        self.gameDuration = gameDuration
        self.courtCount = courtCount
    }
    
    var gameDuration: TimeInterval
    var courtCount: Int
    
    var startTime: Date = Date()
    var player: [Player] = []
}
