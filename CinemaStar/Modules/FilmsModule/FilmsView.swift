// FilmsView.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import SwiftUI

/// Вью экрана с фильмами
struct FilmsView: View {
    @StateObject var presenter: FilmsPresenter
    @Query var swiftDataStoredFilms: [SwiftDataFilm]
    @Environment(\.modelContext) var context

    var body: some View {
        NavigationStack {
            backgroundStackView(color: gradientColor) {
                VStack {
                    switch presenter.state {
                    case .loading:
                        FilmsShimmerView()
                    case let .data(fetchedMovies):
                        if fetchedMovies.isEmpty {
                            FilmsCollectionView(swiftDataFilms: swiftDataStoredFilms)
                        } else {
                            FilmsCollectionView(films: fetchedMovies)
                        }
                    case .error:
                        Text("ERROR!!!")
                    }
                }
                .environmentObject(presenter)
                .background(
                    NavigationLink(
                        destination:
                        Builder.buildFilmDetailsModule(id: presenter.selectedFilmID ?? 0),
                        isActive: Binding(
                            get: { presenter.selectedFilmID != nil },
                            set: { if !$0 { presenter.selectedFilmID = nil } }
                        )
                    ) {
                        EmptyView()
                    }
                )
                .onAppear {
                    guard case .loading = presenter.state else { return }
                    if swiftDataStoredFilms.isEmpty {
                        presenter.prepareFilms(context: context)
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

    init(presenter: FilmsPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }
}

#Preview {
    FilmsView(presenter: FilmsPresenter())
}

/// Вью с фильмами
struct FilmsCollectionView: View {
    @EnvironmentObject var presenter: FilmsPresenter

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var films: [Film] = []
    var swiftDataFilms: [SwiftDataFilm] = []

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
                    if films.isEmpty {
                        ForEach(swiftDataFilms, id: \.id) { film in
                            VStack {
                                if let image = UIImage(data: film.image ?? Data()) {
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
                                    Text(String(film.filmName))
                                    Text("⭐️ \(String(format: "%.1f", film.rating))")
                                }
                                .frame(width: 170, height: 40, alignment: .leading)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                presenter.goToDetailScreen(with: film.filmID)
                            }
                        }
                    } else {
                        ForEach(films, id: \.id) { film in
                            VStack {
                                if let image = film.image {
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
                                    Text(String(film.filmName ?? ""))
                                    Text("⭐️ \(String(format: "%.1f", film.rating ?? 0.0))")
                                }
                                .frame(width: 170, height: 40, alignment: .leading)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                presenter.goToDetailScreen(with: film.id)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
