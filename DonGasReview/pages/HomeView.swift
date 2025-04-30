//
//  ContentView.swift
//  DonGasReview
//
//  Created by 김용해 on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("DongasMan")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}

#Preview {
    ContentView()
}
