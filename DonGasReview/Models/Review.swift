//
//  Review.swift
//  DonGasReview
//
//  Created by 김용해 on 5/3/25.
//
import Foundation
import SwiftData

@Model
class Review: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var storeName: String
    var note: String
    var stars: Int
    var createdAt: Date
    var updatedAt: Date
    
    init(storeName: String, note: String, stars: Int, createdAt: Date, updatedAt: Date) {
        self.storeName = storeName
        self.note = note
        self.stars = stars
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
