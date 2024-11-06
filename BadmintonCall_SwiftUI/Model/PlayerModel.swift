//
//  PlayerModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import Foundation
import SwiftUICore

public enum Gender: String {
    case male = "生理男性"
    case female = "生理女性"
}

enum Level: Int {
    case coach    = 5
    case high     = 4
    case advanced = 3
    case middle   = 2
    case normal   = 1
    case beginner = 0
    
    var color: Color {
        switch self {
        case .coach:    return Color.purple
        case .high:     return Color.red
        case .advanced: return Color.orange
        case .middle:   return Color.yellow
        case .normal:   return Color.green
        case .beginner: return Color.mint
        }
    }
    
    var nameTag: String {
        switch self {
        case .coach:    return "教練"
        case .high:     return "高手"
        case .advanced: return "進階"
        case .middle:   return "中階"
        case .normal:   return "普通"
        case .beginner: return "新手"
        }
    }
}

enum PaymentType {
    case payed
    case notPayYet
    case quarterly
}

struct Player: Identifiable, Hashable {
    init(name: String, gender: Gender, level: Level) {
        self.name = name
        self.gender = gender
        self.level = level
    }
    
    let id = UUID()
    var partner: String? = nil
    var name: String
    var gender: Gender
    var level: Level
    
    // 球友第一次建檔的時間
    var joinDate: Date = Date()
    
    // 球友參與的次數
    var joinTimes: Int = 0
    
    // 球友當天的上場次數
    var playTimes: Int = 0
    
    // 當天已繳費
    var payed: PaymentType = .notPayYet
    
    // 隊友的 ID
    var partnerID: String? = nil
    
    static let demoArray: [Player] = [
        Player(name: "祐3", gender: .female, level: .normal),
        Player(name: "依依 2", gender: .female, level: .beginner),
        Player(name: "Steven", gender: .male, level: .coach),
        Player(name: "依依", gender: .female, level: .normal),
        Player(name: "Fei", gender: .male, level: .middle),
        Player(name: "立瑋", gender: .female, level: .normal),
        Player(name: "大貓", gender: .female, level: .high),
        Player(name: "Dominic 1", gender: .male, level: .middle),
        Player(name: "Dominic 2", gender: .male, level: .middle),
        Player(name: "Ace", gender: .male, level: .middle),
        Player(name: "曉琪", gender: .female, level: .middle),
        Player(name: "祐", gender: .male, level: .middle),
        Player(name: "Ivan", gender: .male, level: .middle),
        Player(name: "璇", gender: .male, level: .high),
        Player(name: "竑佑", gender: .male, level: .middle),
        Player(name: "依依 3", gender: .male, level: .middle),
        Player(name: "小菜 1", gender: .male, level: .high),
        Player(name: "小菜 2", gender: .male, level: .high),
        Player(name: "小菜 3", gender: .male, level: .high),
        Player(name: "阿伸", gender: .male, level: .high),
        Player(name: "Ryan", gender: .male, level: .high),
        Player(name: "nina", gender: .female, level: .middle),
        Player(name: "瑞", gender: .male, level: .middle),
        Player(name: "沛昀", gender: .female, level: .middle),
        Player(name: "8123", gender: .male, level: .middle),
        Player(name: "8123 +", gender: .male, level: .middle),
        Player(name: "James", gender: .male, level: .middle),
        Player(name: "書開", gender: .male, level: .middle),
        Player(name: "Wei(偉)", gender: .male, level: .middle),
        Player(name: "小張", gender: .male, level: .middle),
        Player(name: "阿晉", gender: .male, level: .middle)
    ]
}
