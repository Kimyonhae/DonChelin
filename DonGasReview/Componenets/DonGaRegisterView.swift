//
//  DonGaRegisterView.swift
//  DonGasReview
//
//  Created by 김용해 on 5/3/25.
//

import SwiftUI

struct DonGaRegisterView: View {
    @Binding var storeName: String
    @Binding var address: String
    @Binding var note: String
    @State private var stars: Int = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                customTextField(placeholder: "가게 이름", text: $storeName)
                HStack {
                    Image(systemName: "location")
                    Text("여기에는 이제 주소가 들어갈 예정입니다")
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
                
                TextEditor(text: $note)
                    .frame(height: 150)
                    .padding()
                    .scrollContentBackground(.hidden)
                    .background(Color(hex: "F6F8FE"))
                    .clipShape(.rect(cornerRadius: 8))

                Button(action: {
                    dismiss()
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
    DonGaRegisterView(storeName: .constant(""), address: .constant(""), note: .constant(""))
}
