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
        NavigationStack {
            List {
                Section("Your Information") {
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

                if !self.viewModel.name.isEmpty {
                    NavigationLink(
                        destination: FortuneResultView(
                            viewModel: FortuneResultViewModel(
                                user: self.viewModel.createUserFromInput(),
                                modelContext: .init(PrefectureFortuneApp.sharedModelContainer),
                                fortuneTeller: FortuneAPIClient.shared
                            )
                        ),
                        label: {
                            Text("Check Fortune!")
                                .bold()
                                .foregroundStyle(.blue)
                        }
                    )
                } else {
                    Text("Check Fortune!")
                        .bold()
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    FortuneView(viewModel: FortuneViewModel())
}
