//
//  FortuneView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/07.
//

import SwiftUI
import Combine

struct FortuneView: View {
    @State var viewModel: FortuneViewModel

    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    Section {
                        TextField("Enter your name", text: Binding<String>(
                            get: { self.viewModel.name },
                            set: {
                                // 文字数を制限して set する
                                self.viewModel.name = String(
                                    $0.prefix(FortuneViewModel.maxNameLength)
                                )
                            }
                        ))

                        DatePicker(
                            "Birthday",
                            selection: self.$viewModel.birthday,
                            displayedComponents: .date
                        )

                        Picker("Blood Type", selection: self.$viewModel.bloodType) {
                            ForEach(User.BloodType.allCases, id: \.self) { (type) in
                                Text(type.displayName).tag(type)
                            }
                        }
                    }

                    Button {
                        self.viewModel.onTapFortuneButton()
                    } label: {
                        Text("Check Fortune!")
                            .bold()
                            .foregroundStyle(
                                (self.viewModel.name.isEmpty || self.viewModel.isLoading) ? .gray : .blue
                            )
                    }
                    .disabled(self.viewModel.name.isEmpty || self.viewModel.isLoading)
                }
                .navigationDestination(isPresented: self.$viewModel.isLoaded, destination: {
                    PrefectureView(prefecture: self.viewModel.resultPrefecture)
                })
                .navigationTitle("Your Information")
            }

            if self.viewModel.isLoading {
                ProgressView()
            }
        }
    }
}

fileprivate struct FortuneViewPreviewWrapper: View {
    private class MockFortuneAPIClient: PrefectureInfoProvider {
        func getPrefectureInfo(from: User) async throws -> PrefectureInfo {
            sleep(2)
            throw PrefectureError.failed
        }

        enum PrefectureError: Error {
            case failed
        }
    }

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        FortuneView(
            viewModel: .init(
                modelContext: self.modelContext,
                prefectureInfoProvider: MockFortuneAPIClient()
            )
        )
    }
}

#Preview {
    FortuneViewPreviewWrapper()
        .modelContainer(Prefecture.previewModelContainer)
}
