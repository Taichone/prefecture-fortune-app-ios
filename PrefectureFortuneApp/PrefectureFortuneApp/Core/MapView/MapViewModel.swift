//
//  MapViewModel.swift
//  PrefectureFortuneApp
//
//  Created by Taichi on 2024/06/10.
//

import SwiftUI
import MapKit

@Observable
final class MapViewModel {
    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.682839, longitude: 139.759455),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    init(locationName: String) {
        self.searchLocation(by: locationName)
    }

    private func searchLocation(by name: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            guard let placemarks = placemarks, let location = placemarks.first?.location else {
                print("Location not found")
                return
            }
            DispatchQueue.main.async {
                let region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                self.cameraPosition = .region(region)
            }
        }
    }
}
