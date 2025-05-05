//
//  Address.swift
//  DonGasReview
//
//  Created by 김용해 on 5/5/25.
//
import Foundation

struct AddressResponse: Codable {
    let documents: [Document]
}

struct Document: Codable {
    let address: DetailAddress
}

struct DetailAddress: Codable {
    let address_name : String
}
