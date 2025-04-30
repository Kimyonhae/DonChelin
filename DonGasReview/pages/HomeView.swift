//
//  ContentView.swift
//  DonGasReview
//
//  Created by 김용해 on 4/30/25.
//

import SwiftUI

struct HomeView: View {
    let menu: [Menu] = [
        Menu(title: "돈슐랭 가이드"),
        Menu(title: "별돈"),
        Menu(title: "돈투어"),
        Menu(title: "내 돈슐랭")
    ]
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ZStack {
                        Image("DonGasMan")
                            .aspectRatio(contentMode: .fit)
                        
                        Text("돈슐랭")
                            .font(.custom("BM JUA", size: 60))
                            .foregroundStyle(Color(hex: "39291A"))
                            .offset(x: 0, y: 120)
                    }

                    ForEach(menu) {
                        menuList(title: $0.title)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColor)
        }
    }
    
    // TODO: 선택 매뉴 Component
    private func menuList(title: String) -> some View {
        HStack {
            Text(title)
                .font(.custom("BM JUA", size: 24))
                .foregroundColor(Color(hex: "39291A"))
            Spacer()
            Image(systemName: "chevron.right")
                .font(.system(size: 30, weight: .medium))
                .foregroundColor(Color(hex: "39291A"))
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "39291A"), lineWidth: 3)
        )
        
    }
}

#Preview {
    HomeView()
}
