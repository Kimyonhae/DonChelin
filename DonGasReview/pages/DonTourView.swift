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
    @Environment(\.modelContext) private var modelContext
    @State private var isPresent: Bool = false
    @State private var storeName: String = ""
    @State private var address: String = ""
    @State private var note: String = ""
    var body: some View {
        VStack {
            ZStack {
                MapView(location: location)
                    .ignoresSafeArea(edges: .bottom)
                Image(systemName: "mappin.and.ellipse")
                    .font(.title)
                    .offset(x: 0, y: self.location.isChanging ? -10 : 0)
                
                VStack {
                    Spacer()
                    Button(action: {
                        isPresent.toggle()
                    }, label: {
                        Text("돈슐랭 등록하기")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationTitle("돈가스 여행 지도")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresent) {
            DonGaRegisterView(
                storeName: $storeName, address: $address, note: $note
            )
            .presentationDetents([.fraction(0.4)])
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
    NavigationStack {
        DonTourView()
    }
}
