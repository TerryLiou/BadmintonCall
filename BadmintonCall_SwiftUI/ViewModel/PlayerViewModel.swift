//
//  PlayerViewModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/11/3.
//

import Combine
import Foundation

class PlayerViewModel: ObservableObject {
    @Published var players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
    
    init(isDemo: Bool) {
        if isDemo {
            players = Player.demoArray
        } else {
            players = []
        }
    }
    
    func setupPartner(for player: Player, by id: String) {
        if let index = players.firstIndex(where: { $0.id == player.id }) {
            players[index].partnerID = id
        }
    }
    
    func removePlayer(by id: UUID) {
        if let index = players.firstIndex(where: { $0.id == id }) {
            players.remove(at: index)
        }
    }
    
    func appendPlayer(by player: Player) {
        players.append(player)
    }
}
