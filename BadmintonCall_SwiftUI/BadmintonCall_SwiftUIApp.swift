//
//  BadmintonCall_SwiftUIApp.swift
//  BadmintonCall_SwiftUI
//
//  Created by 劉洧熏 on 2024/10/1.
//

import SwiftUI

@main
struct BadmintonCall_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var playersViewModel = PlayerViewModel(isDemo: true)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(playersViewModel)
        }
    }
}
