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
                Text(self.prefecture.name)
                Text("Capital: " + self.prefecture.capital)
                Text(
                    self.prefecture.hasCoastLine ?
                    "With coastline" : "No coastline"
                )
                if let month = self.prefecture.citizenMonth,
                   let day = self.prefecture.citizenDay {
                    Text("CitizenDay: " + "\(month)/\(day)")
                }
                Text(self.prefecture.brief)
                PrefectureImage(imageUrl: self.prefecture.logoUrl)
                NavigationLink(
                    destination: MapView(
                        viewModel: MapViewModel(
                            locationName: self.prefecture.capital
                        )
                    ),
                    label: {
                        Text("Check the location!")
                            .bold()
                            .foregroundStyle(.blue)
                    }
                )
            }
        }
    }
}

#Preview {
    PrefectureView(prefecture: Prefecture.aichi)
}

