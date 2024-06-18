// View + Extension.swift

import SwiftUI

extension View {
    func backgroundStackView<Content: View, S: ShapeStyle>(color: S, content: () -> Content) -> some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
            content()
        }
    }
}
