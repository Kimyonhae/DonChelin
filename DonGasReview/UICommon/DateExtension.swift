//
//  DateExtension.swift
//  DonGasReview
//
//  Created by 김용해 on 5/6/25.
//

import Foundation

extension Date {
    func formattedKoreanDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: self)
    }
}
