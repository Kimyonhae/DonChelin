//
//  DonTourView.swift
//  DonGasReview
//
//  Created by 김용해 on 5/1/25.
//

import SwiftUI
import MapKit

struct DonTourView: View {
    @StateObject var location = LocationManager()
    var body: some View {
        ZStack {
            MapView(location: location)
                .ignoresSafeArea()
            Image(systemName: "mappin.and.ellipse")
                .font(.title)
                .offset(x: 0, y: self.location.isChanging ? -10 : 0)
        }
    }
}

// SwiftUI에서 UIKit 코드 사용 (MapKit 사용)
struct MapView: UIViewRepresentable {
    let location: LocationManager
    
    func makeCoordinator() -> Coordinator {
        Coordinator(locationManager: location)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    // coordinate는 좌표 , span -> 범위, region 은 맵의 영역
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let newLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        uiView.setCenter(newLocation, animated: true)
    }
}

class Coordinator: NSObject ,MKMapViewDelegate {
    var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        DispatchQueue.main.async {
            withAnimation(.spring) {
                self.locationManager.isChanging = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        DispatchQueue.main.async {
            withAnimation(.spring) {
                self.locationManager.isChanging = false
            }
        }
    }
}



#Preview {
    DonTourView()
}
