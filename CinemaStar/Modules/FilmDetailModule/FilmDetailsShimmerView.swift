// FilmDetailsShimmerView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Шиммер для экрана с детальным описанием фильма
struct FilmDetailsShimmerView: View {
    let items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    var body: some View {
        backgroundStackView(color: gradientColor) {
            scrollView
                .navigationBarBackButtonHidden(true)
        }
    }

    private var scrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                makeFilmPosterView(film: items)
                Spacer()
                    .frame(height: 16)
                watchButtonView
                Spacer()
                    .frame(height: 16)
                makeCountryProductionView(film: items)
                Spacer()
                    .frame(height: 16)
                makeStarringView(film: items)
                Spacer()
                    .frame(height: 10)
                makeRecommendedFilmsView(film: items)
            }
        }
    }

    private var watchButtonView: some View {
        ShimmerView()
            .foregroundColor(.white)
            .frame(width: 358, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var gradientColor: LinearGradient {
        LinearGradient(colors: [.gradientFirst, .gradientSecond], startPoint: .top, endPoint: .bottom)
    }

    private func makeFilmPosterView(film: [Int]) -> some View {
        HStack {
            ShimmerView()
                .frame(width: 170, height: 200)
                .cornerRadius(10)
            ShimmerView()
                .foregroundColor(.white)
                .frame(width: 170, height: 70, alignment: .leading)
                .cornerRadius(10)
            Spacer()
        }
        .padding(.leading, 18)
    }

    private func makeCountryProductionView(film: [Int]) -> some View {
        VStack(alignment: .leading) {
            ShimmerView()
                .frame(width: 355, height: 100)
                .cornerRadius(10)
                .padding(.leading, 4)
            Spacer()
                .frame(height: 10)
            ShimmerView()
                .frame(width: 355, height: 20)
                .cornerRadius(10)
                .padding(.leading, 4)
        }
        .padding(.horizontal, 15)
    }

    private func makeStarringView(film: [Int]) -> some View {
        VStack(alignment: .leading) {
            ShimmerView()
                .frame(width: 355, height: 20)
                .cornerRadius(10)
                .padding(.leading, 4)
            Spacer()
                .frame(height: 15)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(items, id: \.self) { _ in
                        VStack(spacing: 2) {
                            ShimmerView()
                                .frame(width: 50, height: 72)
                                .cornerRadius(8)
                            Spacer()
                                .frame(height: 4)
                            ShimmerView()
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
                ShimmerView()
                    .frame(width: 355, height: 45)
                    .cornerRadius(10)
                    .padding(.leading, 4)
            }
        }
        .padding(.leading, 16)
        .foregroundColor(.white)
    }

    private func makeRecommendedFilmsView(film: [Int]) -> some View {
        VStack(alignment: .leading) {
            ShimmerView()
                .frame(width: 355, height: 15)
                .cornerRadius(10)
                .padding(.leading, 4)
            Spacer()
                .frame(height: 12)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    VStack(alignment: .trailing) {
                        ShimmerView()
                            .frame(width: 170, height: 220)
                            .cornerRadius(8)
                            .padding(.leading, 4)
                        ShimmerView()
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
    FilmDetailsShimmerView()
}
