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
    var name = ""
    var birthday = Date()
    var bloodType = User.BloodType.a
    var fortuneResultViewIsLoading = true
    private(set) var resultPrefecture = Prefecture()
    var modelContext: ModelContext? = nil
    let fortuneTeller: PrefectureFortuneTeller
    let backNavigationTrigger = PassthroughSubject<Void, Never>()

    init(
        modelContext: ModelContext? = nil,
        fortuneTeller: PrefectureFortuneTeller
    ) {
        self.modelContext = modelContext
        self.fortuneTeller = fortuneTeller
    }

    func onFortuneResultViewAppear() {
        Task {
            self.fortuneResultViewIsLoading = true
            await self.fetchResultPrefecture()
            self.fortuneResultViewIsLoading = false
        }
    }

    private func fetchResultPrefecture() async {
        let user = User(
            name: self.name,
            birthday: self.birthday.convertToYearMonthDay(),
            bloodType: self.bloodType
        )

        do {
            let result = try await self.fortuneTeller.fetchFortuneResultPrefecture(from: user)
            self.resultPrefecture = result
            self.addPrefecture(result)
        } catch {
            self.backNavigationTrigger.send() // FortuneView に戻す
            print(error)
        }
    }

    private func addPrefecture(_ prefecture: Prefecture) {
        guard let modelContext = self.modelContext else { return }

        modelContext.insert(prefecture)
    }
}

extension FortuneViewModel {
    /// Fortune API の RequestBody.name 文字数上限
    static let maxNameLength = 127
}

protocol PrefectureFortuneTeller {
    func fetchFortuneResultPrefecture(from: User) async throws -> Prefecture
}
