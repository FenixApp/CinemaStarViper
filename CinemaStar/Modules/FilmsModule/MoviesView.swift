// MoviesView.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import SwiftUI

/// Вью экрана с фильмами
struct MoviesView: View {
    @StateObject var presenter: MoviesPresenter
    @Query var swiftDataStoredMovies: [SwiftDataMovie]
    @Environment(\.modelContext) var context

    var body: some View {
        NavigationStack {
            backgroundStackView(color: gradientColor) {
                VStack {
                    switch presenter.state {
                    case .loading:
                        shimmer
                    case let .data(fetchedMovies):
                        if fetchedMovies.isEmpty {
                            MoviesCollectionView(swiftDataMovies: swiftDataStoredMovies)
                        } else {
                            MoviesCollectionView(movies: fetchedMovies)
                        }
                    case .error:
                        Text("ERROR!!!")
                    }
                }
                .environmentObject(presenter)
                .background(
                    NavigationLink(
                        destination:
                        ViewBuilder.buildMoviesDetailModule(id: presenter.selectedMovieID ?? 0),
                        isActive: Binding(
                            get: { presenter.selectedMovieID != nil },
                            set: { if !$0 { presenter.selectedMovieID = nil } }
                        )
                    ) {
                        EmptyView()
                    }
                )
                .onAppear {
                    guard case .loading = presenter.state else { return }
                    if swiftDataStoredMovies.isEmpty {
                        presenter.prepareMovies(context: context)
                    } else {
                        presenter.state = .data([])
                    }
                }
            }
        }
    }

    private var shimmer: some View {
        VStack {
            Rectangle()
                .fill(Color.appLightGray.opacity(0.3))
                .cornerRadius(12)
                .frame(width: 240, height: 60)
                .padding(.trailing, 120)
                .padding(.bottom, 25)
                .shimmerPlaying()
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0 ..< 6, id: \.self) { _ in
                    VStack {
                        Rectangle()
                            .fill(Color.appLightGray.opacity(0.3))
                            .frame(width: 170, height: 200)
                            .shimmerPlaying()
                        Rectangle()
                            .fill(Color.appLightGray.opacity(0.3))
                            .frame(width: 170, height: 40)
                            .shimmerPlaying()
                    }
                    .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 10)
        }
    }

    private var gradientColor: LinearGradient {
        LinearGradient(colors: [.gradientFirst, .gradientSecond], startPoint: .top, endPoint: .bottom)
    }

    init(presenter: MoviesPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
}

#Preview {
    MoviesView(presenter: MoviesPresenter())
}

/// Вью с фильмами
struct MoviesCollectionView: View {
    @EnvironmentObject var presenter: MoviesPresenter

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var movies: [Movie] = []
    var swiftDataMovies: [SwiftDataMovie] = []

    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Смотри исторические\nфильмы на ")
                    +
                    Text("CINEMA STAR")
                    .fontWeight(.heavy)
            }
            .padding(.horizontal)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(movies, id: \.id) { movie in
                        VStack {
                            if let image = movie.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 170, height: 220)
                                    .cornerRadius(8)
                            } else {
                                ProgressView()
                                    .frame(width: 170, height: 220)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(String(movie.movieName ?? ""))
                                Text("⭐️ \(String(format: "%.1f", movie.rating ?? 0.0))")
                            }
                            .frame(width: 170, height: 40, alignment: .leading)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            presenter.goToDetailScreen(with: movie.id)
                            print(movie.id)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
