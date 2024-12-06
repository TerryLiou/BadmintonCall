//
//  PlayerViewModel.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/11/3.
//

import Combine
import UIKit

class PlayerViewModel: ObservableObject {
    @Published var players: [Player]
    @Published var isLandscapeMode: Bool = UIDevice.current.orientation.isLandscape
    
    let playerCollectionViewWidth: CGFloat = 280.0
    
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
    
    private func registerOrientation() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(orientationDidChange),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    @objc private func orientationDidChange() {
        isLandscapeMode = UIDevice.current.orientation.isLandscape
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
    
    func getCourtViewWidth(screenSize: CGSize) -> CGFloat {
        return screenSize.width - playerCollectionViewWidth
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
