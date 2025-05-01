//
//  Menu.swift
//  DonGasReview
//
//  Created by 김용해 on 5/1/25.
//
import SwiftUI

struct Menu<Destination: View>: Identifiable{
    let id: UUID = UUID()
    let title: String
    let destination: Destination
}
