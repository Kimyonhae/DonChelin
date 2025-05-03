//
//  DonGasReviewApp.swift
//  DonGasReview
//
//  Created by 김용해 on 4/30/25.
//

import SwiftUI
import SwiftData

@main
struct DonGasReviewApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Review.self)
    }
}
