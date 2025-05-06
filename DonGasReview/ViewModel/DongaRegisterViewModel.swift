//
//  DongaRegisterViewModel.swift
//  DonGasReview
//
//  Created by 김용해 on 5/5/25.
//

import Combine
import Foundation

class DongaRegisterViewModel: ObservableObject {
    @Published var storeName: String = ""
    @Published var address: String = ""
    @Published var note: String = ""
    @Published var isLoading: Bool = false
    let latitude: Double
    let longitude: Double
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        addressCheck()
    }
    
    private func addressCheck() {
        guard let url = URL(string: "https://dapi.kakao.com/v2/local/geo/coord2address.json?x=\(longitude)&y=\(latitude)&input_coord=WGS84") else {
            return
        }
        self.isLoading = true
        var request = URLRequest(url: url)
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KakaoAPIKey") as? String else {
            return
        }
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200  else {
                    throw URLError(.badServerResponse)
                }
                
                return result.data
            }
            .decode(type: AddressResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let err):
                    print("Address Errorr Message : \(err.localizedDescription)")
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] value in
                if let existValue = value.documents.first {
                    self?.address = existValue.address.address_name
                }else {
                    self?.isLoading = true
                }
            })
            .store(in: &cancellables)
    }
}










