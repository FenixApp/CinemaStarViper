// FilmsView.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import SwiftUI

/// Вью экрана с фильмами
struct FilmsView: View {
    @StateObject var presenter: MoviesPresenter
    @Query var swiftDataStoredMovies: [SwiftDataMovie]
    @Environment(\.modelContext) var context

    var body: some View {
        NavigationStack {
            backgroundStackView(color: gradientColor) {
                VStack {
                    switch presenter.state {
                    case .loading:
                        MoviesShimmerView()
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
                        Builder.buildMoviesDetailModule(id: presenter.selectedMovieID ?? 0),
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

    private var gradientColor: LinearGradient {
        LinearGradient(colors: [.gradientFirst, .gradientSecond], startPoint: .top, endPoint: .bottom)
    }

    init(presenter: MoviesPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
}

#Preview {
    FilmsView(presenter: MoviesPresenter())
}

/// Вью с фильмами
struct MoviesCollectionView: View {
    @EnvironmentObject var presenter: MoviesPresenter

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var movies: [Film] = []
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
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    if movies.isEmpty {
                        ForEach(swiftDataMovies, id: \.id) { movie in
                            VStack {
                                if let image = UIImage(data: movie.image ?? Data()) {
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
                                    Text(String(movie.movieName))
                                    Text("⭐️ \(String(format: "%.1f", movie.rating))")
                                }
                                .frame(width: 170, height: 40, alignment: .leading)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                presenter.goToDetailScreen(with: movie.movieID)
                            }
                        }
                    } else {
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
                                    Text(String(movie.filmName ?? ""))
                                    Text("⭐️ \(String(format: "%.1f", movie.rating ?? 0.0))")
                                }
                                .frame(width: 170, height: 40, alignment: .leading)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                presenter.goToDetailScreen(with: movie.id)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
