//
//  MapView.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/10.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var viewModel: MapViewModel

    var body: some View {
        VStack {
            Map(initialPosition: self.viewModel.cameraPosition)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MapView(viewModel: MapViewModel(locationName: Prefecture.aichi.capital))
}
