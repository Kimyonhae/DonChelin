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
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            ZStack {
                MapView(location: location)
                    .ignoresSafeArea(edges: .bottom)
                Image("DonGasmarker")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60) // 원하는 크기로 조절
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
            DonGaRegisterView(location: location)
            .presentationDetents([.fraction(0.4)])
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("뒤로가기")
                }
                .foregroundStyle(.blue)
                .onTapGesture {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: {
                    DonsulangView()
                }, label: {
                    Image(systemName: "pencil.circle")
                })
            }
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
        let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
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
            // 위치를 맵의 가운데로 받아오기
            self.locationManager.latitude = mapView.centerCoordinate.latitude
            self.locationManager.longitude = mapView.centerCoordinate.longitude
        }
    }
}



#Preview {
    NavigationStack {
        DonTourView()
    }
}
