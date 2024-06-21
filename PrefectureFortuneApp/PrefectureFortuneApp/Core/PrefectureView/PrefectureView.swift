//
//  PrefectureView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/08.
//

import SwiftUI

struct PrefectureView: View {
    let prefecture: Prefecture

    var body: some View {
        NavigationStack {
            List {
                Text(
                    String(
                        localized: "Capital"
                    ) + ": \(self.prefecture.info.capital)"
                )
                Text(
                    self.prefecture.info.hasCoastLine ?
                    String(
                        localized: "With coastline"
                    ) : String(
                        localized: "No coastline"
                    )
                )
                if let month = self.prefecture.info.citizenMonth,
                   let day = self.prefecture.info.citizenDay {
                    Text(
                        String(
                            localized: "Citizen day"
                        ) + ": \(month)/\(day)"
                    )
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

