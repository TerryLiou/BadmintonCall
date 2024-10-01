//
//  PlayerModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import Foundation

public enum Gender: String {
    case male = "生理男性"
    case female = "生理女性"
}


enum Level: Int {
    case high   = 2
    case middle = 1
    case normal = 0
}

struct Player {
    init(name: String, gender: Gender, level: Level) {
        self.name = name
        self.gender = gender
        self.level = level
    }
    
    var name: String
    var gender: Gender
    var level: Level
    
    // 球友第一次建檔的時間
    var joinDate: Date = Date()
    
    // 球友參與的次數
    var joinTimes: Int = 0
}
