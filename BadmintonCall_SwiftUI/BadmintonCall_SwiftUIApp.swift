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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
