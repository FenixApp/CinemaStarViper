// ShimmerStyle.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стиль для шиммера
struct ShimmerStyle: ViewModifier {
    @State private var phase: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .cornerRadius(12)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [.clear, Color.white.opacity(0.4), .clear]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: 200)
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 300
                }
            }
            .cornerRadius(12)
    }
}

extension View {
    func shimmerPlaying() -> some View {
        modifier(ShimmerStyle())
    }
}
