//
//  NextView.swift
//  DonGasReview
//
//  Created by 김용해 on 5/1/25.
//

import SwiftUI
import SwiftData

struct DonsulangView: View {
    @State private var selection = "List"
    @Environment(\.dismiss) private var dismiss
    @Query private var reviews: [Review]
    @Environment(\.modelContext) private var modelContext
    @State private var isAlert: Bool = false
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(red: 57/255, green: 41/255, blue: 26/255, alpha: 1.0),
            .font: UIFont(name: "BM JUA", size: 40)!
        ]
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SegmentedTabView()
                if reviews.isEmpty {
                    GeometryReader { geo in
                        VStack {
                            Spacer()
                            Text("현재 리뷰가 없습니다")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color(hex: "39291A"))
                                .font(.custom("BM JUA", size: 30))
                                .padding()
                            Spacer()
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.7)
                }else {
                    ForEach(reviews, id: \.id) { review in
                        DonGasReviewItem(review: review){
                            self.isAlert.toggle()
                        }
                        .alert("돈슐랭 리뷰 삭제", isPresented: $isAlert) {
                            Button("취소", role: .cancel) {
                                print("취소됨")
                            }
                            Button("삭제", role: .destructive) {
                                do {
                                    modelContext.delete(review)
                                    try modelContext.save()
                                }catch {
                                    print("삭제 Error : \(error)")
                                }
                            }
                        } message: {
                            Text("이 작업은 되돌릴 수 없습니다")
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color.backgroundColor)
        .navigationTitle("돈슐랭")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("뒤로가기")
                }
                .foregroundStyle(Color(hex: "39291A"))
                .onTapGesture {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DonsulangView()
    }
}

struct SegmentedTabView: View {
    @State private var selected = 0
    let titles = ["List", "Map"]
    let icons = ["list.bullet", "map"]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<titles.count, id: \.self) { index in
                Button(action: {
                    withAnimation(.spring) {
                        selected = index
                    }
                }) {
                    HStack {
                        Image(systemName: icons[index])
                        Text(titles[index])
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selected == index ? Color(hex: "39291A") : Color.white)
                    .foregroundColor(selected == index ? .white : Color(hex: "39291A") )
                }
            }
        }
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color(hex: "39291A"), lineWidth: 1))
    }
}

