//
//  FortuneResultViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/10.
//

import Foundation
import SwiftData
import Combine

@Observable
final class FortuneResultViewModel {
    var isLoading = true
    private(set) var resultPrefecture = Prefecture()
    var modelContext: ModelContext? = nil
    let user: User
    let prefectureProvider: PrefectureProvider
    let backNavigationTrigger = PassthroughSubject<Void, Never>()

    init(
        user: User,
        modelContext: ModelContext? = nil,
        prefectureProvider: PrefectureProvider
    ) {
        self.user = user
        self.modelContext = modelContext
        self.prefectureProvider = prefectureProvider
    }

    func onFortuneResultViewAppear() {
        Task {
            self.isLoading = true
            await self.fetchResultPrefecture()
            self.isLoading = false
        }
    }

    private func fetchResultPrefecture() async {
        do {
            let result = try await self.prefectureProvider.getPrefecture(from: self.user)
            self.resultPrefecture = result
            self.addPrefecture(result)
        } catch {
            self.backNavigationTrigger.send() // FortuneView に戻す
            print(error)
        }
    }

    /// Adds a `Prefecture` to the `modelContext`.
    ///
    /// This method checks if a `Prefecture` with the same `name` already exists in the `modelContext`.
    /// - If it does not exist, the method inserts the provided `Prefecture` into the `modelContext`.
    /// - If it does exist, the method updates the `lastFortuneTellingDate` of the existing `Prefecture` to the current date.
    ///
    /// - Parameter prefecture: The `Prefecture` to be added or updated.
    private func addPrefecture(_ prefecture: Prefecture) {
        guard let modelContext = self.modelContext else { return }

        do {
            let descriptor = FetchDescriptor<Prefecture>(sortBy: [SortDescriptor(\.name)])
            let prefectures = try modelContext.fetch(descriptor)
            if let existingPrefecture = prefectures.first(where: { $0.name == prefecture.name }) {
                existingPrefecture.lastFortuneTellingDate = Date()
            } else {
                modelContext.insert(prefecture)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return
        }
    }
}

protocol PrefectureProvider {
    func getPrefecture(from: User) async throws -> Prefecture
}
