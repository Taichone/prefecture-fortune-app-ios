//
//  FortuneViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import Foundation
import SwiftData

@Observable
final class FortuneViewModel {
    // MARK: user-input properties
    var name = ""
    var birthday = Date()
    var bloodType = User.BloodType.a

    // MARK: properties
    private var modelContext: ModelContext? = nil
    private let prefectureInfoProvider: PrefectureInfoProvider
    private(set) var resultPrefecture = Prefecture(info: .placeholder)
    private(set) var currentAlertEntity = AlertEntity(
        title: "title",
        message: "message",
        actionText: "actionText"
    )
    var isShowingAlert = false
    var isLoaded = false
    private(set) var isLoading = false

    init(
        modelContext: ModelContext? = nil,
        prefectureInfoProvider: PrefectureInfoProvider
    ) {
        self.modelContext = modelContext
        self.prefectureInfoProvider = prefectureInfoProvider
    }

    private func showAlert(title: String, message: String, actionText: String) {
        self.currentAlertEntity = .init(title: title, message: message, actionText: actionText)
        self.isShowingAlert = true
    }

    func showNameTooLongAlert() {
        self.showAlert(
            title: "Name too long",
            message: "Keep your name within \(FortuneViewModel.maxNameLength) characters",
            actionText: "OK"
        )
    }

    @MainActor
    func onTapFortuneButton() {
        if !self.isLoading {
            self.isLoading = true
            Task {
                await self.setResultPrefecture()
                self.isLoading = false
            }
        }
    }

    @MainActor
    private func setResultPrefecture() async {
        self.isLoaded = false
        do {
            let result = try await self.prefectureInfoProvider.getPrefectureInfo(from: self.createUserFromInput())
            self.resultPrefecture = Prefecture(info: result)
            self.addPrefecture(self.resultPrefecture)
            self.isLoaded = true
        } catch {
            self.showAlert(
                title: "Error",
                message: "Failed to fetch the fortune result.",
                actionText: "Close"
            )
            print("Fetch FortuneAPI result Failure: \(error.localizedDescription)")
        }
    }

    private func createUserFromInput() -> User {
        return User(
            name: self.name,
            birthday: self.birthday.convertToYearMonthDay(),
            bloodType: self.bloodType
        )
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
            let descriptor = FetchDescriptor<Prefecture>(sortBy: [SortDescriptor(\.info.name)])
            let prefectures = try modelContext.fetch(descriptor)
            if let existingPrefecture = prefectures.first(where: { $0.info.name == prefecture.info.name }) {
                existingPrefecture.lastFortuneTellingDate = Date()
            } else {
                modelContext.insert(prefecture)
            }
        } catch {
            self.showAlert(
                title: "Error",
                message: "Adding the Prefecture failed.",
                actionText: "Close"
            )
            print("Fetch Prefecture ModelContext Failure: \(error.localizedDescription)")
            return
        }
    }
}

protocol PrefectureInfoProvider {
    func getPrefectureInfo(from: User) async throws -> PrefectureInfo
}

extension FortuneViewModel {
    /// Fortune API の RequestBody.name 文字数上限
    static let maxNameLength = 127
}
