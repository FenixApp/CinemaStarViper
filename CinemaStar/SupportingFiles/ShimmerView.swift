// ShimmerView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Вью с шиммером
struct ShimmerView: View {
    @State private var startPoint: UnitPoint = .init(x: -4, y: 0)
    @State private var endPoint: UnitPoint = .init(x: 0, y: 0)

    private var gradientColors = [
        .clear,
        Color.appLightGray.opacity(0.4),
        .clear
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
                startPoint = .init(x: 2, y: 0)
                endPoint = .init(x: 4, y: 0)
            }
        }
    }
}

#Preview {
    ShimmerView()
}
