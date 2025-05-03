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
    var modelContainer: ModelContainer = {
        let schema = Schema([
            Review.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("ModelContainer를 생성 할 수 없습니다")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(modelContainer)
    }
}
