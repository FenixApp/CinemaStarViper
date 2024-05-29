// MoviesView.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftUI

/// Протокол для взаимодействия с вью
protocol MoviesViewProtocol {}

/// Вью экрана с фильмами
struct MoviesView: View, MoviesViewProtocol {
    @StateObject var presenter: MoviesPresenter

    let items = Array(1 ... 13)

    var body: some View {
        NavigationStack {
            backgroundStackView(color: gradientColor) {
                VStack {
                    switch presenter.state {
                    case .loading:
                        Text("Loading")
                    case let .data(fetchedMovies):
                        MoviesCollectionView(movies: fetchedMovies)
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
            }
        }
        .onAppear {
            presenter.prepareMovies()
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
