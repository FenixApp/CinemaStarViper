// MoviesDetailsShimmerView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Shimmer
struct MoviesDetailsShimmerView: View {
    let items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    var body: some View {
        backgroundStackView(color: gradientColor) {
            ScrollView(showsIndicators: false) {
                VStack {
                    makeMoviePosterView(movie: items)
                    Spacer()
                        .frame(height: 16)
                    watchButtonView
                    Spacer()
                        .frame(height: 16)
                    makeCountryProductionView(movie: items)
                    Spacer()
                        .frame(height: 16)
                    makeStarringView(movie: items)
                    Spacer()
                        .frame(height: 10)
                    makeRecommendedMoviesView(movie: items)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    private var watchButtonView: some View {
        ShimmerBoxView()
            .foregroundColor(.white)
            .frame(width: 358, height: 48)
            .background(.gradientSecond)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var gradientColor: LinearGradient {
        LinearGradient(colors: [.gradientFirst, .gradientSecond], startPoint: .top, endPoint: .bottom)
    }

    private func makeMoviePosterView(movie: [Int]) -> some View {
        HStack {
            ShimmerBoxView()
                .frame(width: 170, height: 200)
                .cornerRadius(10)
            ShimmerBoxView()
                .foregroundColor(.white)
                .frame(width: 170, height: 70, alignment: .leading)
                .cornerRadius(10)
            Spacer()
        }
        .padding(.leading, 18)
    }

    private func makeCountryProductionView(movie: [Int]) -> some View {
        VStack(alignment: .leading) {
            ShimmerBoxView()
                .frame(width: 355, height: 100)
                .cornerRadius(10)
                .padding(.leading, 4)
            Spacer()
                .frame(height: 10)
            ShimmerBoxView()
                .frame(width: 355, height: 20)
                .cornerRadius(10)
                .padding(.leading, 4)
        }
        .padding(.horizontal, 15)
    }

    private func makeStarringView(movie: [Int]) -> some View {
        VStack(alignment: .leading) {
            ShimmerBoxView()
                .frame(width: 355, height: 20)
                .cornerRadius(10)
                .padding(.leading, 4)
            Spacer()
                .frame(height: 15)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(items, id: \.self) { _ in
                        VStack(spacing: 2) {
                            ShimmerBoxView()
                                .frame(width: 50, height: 72)
                                .cornerRadius(8)
                            Spacer()
                                .frame(height: 4)
                            ShimmerBoxView()
                                .frame(width: 50, height: 14)
                                .cornerRadius(8)
                        }
                        .padding(.leading, 4)
                    }
                }
            }
            Spacer()
                .frame(height: 14)
            VStack(alignment: .leading, spacing: 5) {
                ShimmerBoxView()
                    .frame(width: 355, height: 15)
                    .cornerRadius(10)
                    .padding(.leading, 4)
                ShimmerBoxView()
                    .frame(width: 355, height: 15)
                    .cornerRadius(10)
                    .padding(.leading, 4)
            }
        }
        .padding(.leading, 16)
        .foregroundColor(.white)
    }

    private func makeRecommendedMoviesView(movie: [Int]) -> some View {
        VStack(alignment: .leading) {
            ShimmerBoxView()
                .frame(width: 355, height: 15)
                .cornerRadius(10)
                .padding(.leading, 4)
            Spacer()
                .frame(height: 12)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    VStack(alignment: .trailing) {
                        ShimmerBoxView()
                            .frame(width: 170, height: 220)
                            .cornerRadius(8)
                            .padding(.leading, 4)
                        ShimmerBoxView()
                            .frame(width: 170, height: 16)
                            .cornerRadius(10)
                    }
                    .padding(.trailing, 20)
                }
            }
        }
        .padding(.leading, 16)
        .foregroundColor(.white)
    }
}

#Preview {
    MoviesDetailsShimmerView()
}
