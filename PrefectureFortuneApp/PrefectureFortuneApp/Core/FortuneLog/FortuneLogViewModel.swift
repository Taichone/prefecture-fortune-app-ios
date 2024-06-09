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
            // TODO: 最後に占われた日時でソートするよう変更
            let descriptor = FetchDescriptor<Prefecture>(sortBy: [SortDescriptor(\.name)])
            self.prefectures = try modelContext.fetch(descriptor)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
