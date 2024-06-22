//
//  PrefectureView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct PrefectureView: View {
    private let prefecture: Prefecture
    private let prefectureTypeName: String

    init(prefecture: Prefecture) {
        self.prefecture = prefecture
        self.prefectureTypeName = String(prefecture.info.name.last ?? "県")
    }

    var body: some View {
        NavigationStack {
            List {
                Text("The capital is \(self.prefecture.info.capital) \(self.prefectureTypeName)")
                Text(
                    self.prefecture.info.hasCoastLine ?
                    String(localized: "Has a coastline") : String(localized: "No coastline")
                )
                if let month = self.prefecture.info.citizenMonth,
                   let day = self.prefecture.info.citizenDay {
                    Text("Citizen day: \(month)/\(day) \(self.prefectureTypeName)")
                }
                Text(self.prefecture.info.brief)
                PrefectureImage(imageUrl: self.prefecture.info.logoUrl)
                NavigationLink(
                    destination: MapView(
                        viewModel: MapViewModel(
                            locationName: self.prefecture.info.capital
                        )
                    ),
                    label: {
                        Text("Check the location!")
                            .bold()
                            .foregroundStyle(.blue)
                    }
                )
            }
            .navigationTitle(self.prefecture.info.name)
        }
    }
}

#Preview {
    PrefectureView(prefecture: Prefecture(info: .aichi))
}

