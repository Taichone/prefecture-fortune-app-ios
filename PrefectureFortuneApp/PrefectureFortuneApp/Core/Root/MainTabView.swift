//
//  MainTabView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Prefecture.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: self.$selectedIndex) {
            FortuneView(
                viewModel: FortuneViewModel(
                    modelContext: .init(self.sharedModelContainer),
                    fortuneTeller: FortuneAPIClient.shared
                )
            )
            .modelContainer(self.sharedModelContainer)
            .onAppear {
                self.selectedIndex = 0
            }
            .tabItem {
                Image(systemName: "mappin.and.ellipse")
            }.tag(0)

            FortuneLogView(
                viewModel: FortuneLogViewModel(
                    modelContext: .init(self.sharedModelContainer)
                )
            )
            .onAppear {
                self.selectedIndex = 1
            }
            .tabItem {
                Image(systemName: "clock.arrow.circlepath")
            }.tag(1)
        }
    }
}

#Preview {
    MainTabView()
}
