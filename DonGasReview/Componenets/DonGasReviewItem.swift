//
//  DonGasReviewItem.swift
//  DonGasReview
//
//  Created by 김용해 on 5/6/25.
//
import SwiftUI

struct DonGasReviewItem: View {
    let review: Review
    let showAlert: () -> Void
    @GestureState private var longPressCheck = false
    @State private var isPressing = false
    var body: some View {
        let longPress = LongPressGesture(minimumDuration: 0.5)
            .updating($longPressCheck) { currentState, gestureState, _ in
                    gestureState = currentState
                }
            .onEnded { _ in
                withAnimation(.easeIn(duration: 0.2)) {
                    isPressing = true
                }
                // 0.5초 뒤에 false로 바꿔서 초기화
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isPressing = false
                    }
                    showAlert() // alert 창 띄우기
                }
            }
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(review.storeName)
                    .font(.custom("BM JUA", size: 22))
                    .foregroundColor(Color(hex: "39291A"))
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(review.stars)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Text(review.address)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(1)

            Text(review.createdAt.formattedKoreanDate())
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(isPressing ? Color.gray.opacity(0.3) : Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "39291A"), lineWidth: 2)
        )
        .gesture(longPress)
    }
}
