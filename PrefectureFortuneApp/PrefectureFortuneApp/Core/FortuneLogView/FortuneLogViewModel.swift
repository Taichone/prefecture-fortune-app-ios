//
//  FortuneLogViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/09.
//

import Foundation
import SwiftData

@Observable
final class FortuneLogViewModel {
    var modelContext: ModelContext? = nil
    var prefectures: [Prefecture] = []

    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
        self.fetchPrefectureData()
    }

    func onAppear() {
        self.fetchPrefectureData()
    }

    private func fetchPrefectureData() {
        guard let modelContext = self.modelContext else { return }

        do {
            // Prefecture を最後に占われたタイミングの Date の降順でソート
            let descriptor = FetchDescriptor<Prefecture>(sortBy: [SortDescriptor(\.lastFortuneTellingDate, order: .reverse)])
            self.prefectures = try modelContext.fetch(descriptor)
        } catch {
            // TODO: error handling
            print("Error: \(error.localizedDescription)")
        }
    }
}
