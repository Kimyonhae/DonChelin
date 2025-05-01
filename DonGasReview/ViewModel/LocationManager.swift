//
//  LocationManager.swift
//  DonGasReview
//
//  Created by 김용해 on 5/1/25.
//
import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    @Published var isChanging: Bool = false
    @Published var latitude: Double = 37.463737159954015
    @Published var longitude: Double = 126.71542882919312
    @Published var log: String = ""
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        super.init()
        self.locationManager = locationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 권한 요청
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    // 권한 로직
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            log = "권한이 거절되었습니다."
        case .notDetermined:
            log = "권한이 요청되지 않았습니다."
        case .restricted:
            log = "권한이 제한되었습니다"
        case .authorizedWhenInUse, .authorizedAlways:
            log = "권한이 허용되었습니다."
        @unknown default:
                log = "알 수 없는 상태입니다"
        }
    }
    
    // 위치 정보 가져오기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { location in
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
        print("locations : \(locations)")
    }
}
