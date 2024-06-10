//
//  FortuneViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation
import SwiftData
import Combine

@Observable
final class FortuneViewModel {
    // MARK: user-input properties
    var name = ""
    var birthday = Date()
    var bloodType = User.BloodType.a

    // MARK: properties
    private var modelContext: ModelContext? = nil
    private let prefectureProvider: PrefectureProvider
    private(set) var resultPrefecture = Prefecture()
    let backNavigationTrigger = PassthroughSubject<Void, Never>()
    var isLoading = false
    var isLoaded = false

    // TODO: - refactor: createUserFromInput の定義場所を下へ
    private func createUserFromInput() -> User {
        return User(
            name: self.name,
            birthday: self.birthday.convertToYearMonthDay(),
            bloodType: self.bloodType
        )
    }

    init(
        modelContext: ModelContext? = nil,
        prefectureProvider: PrefectureProvider
    ) {
        self.modelContext = modelContext
        self.prefectureProvider = prefectureProvider
    }

    func onTapFortuneButton() {
        if !self.isLoading {
            self.isLoading = true
            Task {
                await self.setResultPrefecture()
                self.isLoading = false
            }
        }
    }

    // TODO: setResultPrefecture を private に
    func setResultPrefecture() async {
        self.isLoaded = false
        do {
            let result = try await self.prefectureProvider.getPrefecture(from: self.createUserFromInput())
            self.resultPrefecture = result
            self.addPrefecture(result)
            self.isLoaded = true
        } catch {
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


extension FortuneViewModel {
    /// Fortune API の RequestBody.name 文字数上限
    static let maxNameLength = 127
}
