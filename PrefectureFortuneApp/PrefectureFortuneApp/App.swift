//
//  App.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/06.
//

import SwiftUI
import SwiftData

@main
struct PrefectureFortuneApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}

extension PrefectureFortuneApp {
    static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Prefecture.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // TODO: アラートを表示して、新規 Container を生成
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
