//
//  DonGaRegisterView.swift
//  DonGasReview
//
//  Created by 김용해 on 5/3/25.
//

import SwiftUI
import SwiftData

struct DonGaRegisterView: View {
    var location: LocationManager
    @StateObject private var viewModel: DongaRegisterViewModel
    @State private var stars: Int = 0
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    init(location: LocationManager) {
        self.location = location
        _viewModel = StateObject(wrappedValue: DongaRegisterViewModel(latitude: location.latitude, longitude: location.longitude))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                customTextField(placeholder: "가게 이름", text: $viewModel.storeName)
                HStack {
                    Image(systemName: "location")
                    if viewModel.isLoading {
                       ProgressView()
                    } else {
                        Text("주소 : \(viewModel.address)")
                    }
                }
                .padding(.vertical, 10)
                HStack {
                    ForEach(0..<5, id: \.self) { index in
                        Image(systemName: index <= stars ? "star.fill" : "star")
                            .foregroundStyle(index <= stars ? .yellow : .black)
                            .onTapGesture {
                                stars = index
                            }
                    }
                }
                .padding(.vertical ,10)
                
                TextEditor(text: $viewModel.note)
                    .frame(height: 150)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .background(Color(hex: "F6F8FE"))
                    .clipShape(.rect(cornerRadius: 8))
                Button(action: {
                    do {
                        defer {
                            dismiss()
                        }
                        let review: Review = .init(
                            storeName: viewModel.storeName,
                            note: viewModel.note,
                            stars: stars,
                            createdAt: Date.now,
                            updatedAt: Date.now
                        )
                        modelContext.insert(review)
                        try modelContext.save()
                    } catch {
                        print("리뷰 생성 오류 : \(error)")
                    }
                }, label: {
                    Text("등록하기")
                        .padding()
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(text: text) {
            Text(placeholder)
        }
        .padding()
        .background(Color(hex: "F6F8FE"))
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    DonGaRegisterView(location: LocationManager())
}
