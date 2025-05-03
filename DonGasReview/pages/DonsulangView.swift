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
    @Query private var reviews: [Review]
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(red: 57/255, green: 41/255, blue: 26/255, alpha: 1.0),
        ]
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SegmentedTabView()
                if reviews.isEmpty {
                    Text("현재 리뷰가 없습니다")
                }else {
                    ForEach(reviews) { review in
                        Text(review.storeName)
                    }
                }
            }
            .padding()
        }
        .background(Color.backgroundColor)
        .navigationTitle("돈슐랭")
        .navigationBarTitleDisplayMode(.large)
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

