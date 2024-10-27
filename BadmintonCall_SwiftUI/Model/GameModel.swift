//
//  GameModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import Foundation

struct GameModel: Identifiable, Hashable {
    init(courtCount: Int) {
        self.courtCount = courtCount
    }
    
    let id = UUID()
    var gameDuration: TimeInterval = Date().timeIntervalSinceNow
    var courtCount: Int
    
    var startTime: Date = Date()
    var player: [Player] = []
}
