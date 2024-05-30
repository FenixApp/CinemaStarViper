// ShimmerView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Представление шиммера
struct ShimmerBoxView: View {
    @State private var startPoint: UnitPoint = .init(x: 0, y: 0)
    @State private var endPoint: UnitPoint = .init(x: 0, y: 0)

    private var gradientColors = [
        //        Color(uiColor: UIColor.systemGray5),
//        Color(uiColor: UIColor.systemGray6),
//        Color(uiColor: UIColor.systemGray5),
        .clear, Color.appLightGray.opacity(0.4), .clear
    ]

    var body: some View {
        LinearGradient(
            colors: gradientColors,
            startPoint: startPoint,
            endPoint: endPoint
        )
        .onAppear {
            withAnimation(
                .linear(duration: 1)
                    .repeatForever(autoreverses: false)
            ) {
                startPoint = .init(x: 0, y: 0)
                endPoint = .init(x: 2, y: 0)
            }
        }
    }
}

#Preview {
    ShimmerBoxView()
}
