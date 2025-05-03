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
    var rating: Double
    var createdAt: Date
    var updatedAt: Date
    
    init(storeName: String, note: String, rating: Double, createdAt: Date, updatedAt: Date) {
        self.storeName = storeName
        self.note = note
        self.rating = rating
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
