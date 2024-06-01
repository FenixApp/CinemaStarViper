// FilmDetailsView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftData
import SwiftUI

// swiftlint:disable all

/// Вью экрана с детальным фильмом
struct FilmDetailsView: View {
    @Environment(\.modelContext) private var context: ModelContext
    @Query var filmDetail: [SwiftDataFilmDetails]
    @Environment(\.dismiss) var dismiss
    @State var isfavoritesTapped = false
    @State var isWatchButtonTapped = false
    @StateObject var presenter: FilmDetailsPresenter

    var id: Int?

    var body: some View {
        backgroundStackView(color: gradientColor) {
            ScrollView(showsIndicators: false) {
                switch presenter.state {
                case .loading:
                    FilmDetailsShimmerView()
                case let .data(movieDetail):
                    let storedFilm = filmDetail.first(where: { $0.filmID == id })
                    VStack {
                        makeFilmPosterView(film: movieDetail, storedFilm: storedFilm)
                        Spacer().frame(height: 16)
                        watchButtonView
                        Spacer().frame(height: 16)
                        makeCountryProductionView(film: movieDetail, storedFilm: storedFilm)
                        Spacer().frame(height: 16)
                        makeStarringView(film: movieDetail, storedFilm: storedFilm)
                        Spacer().frame(height: 10)
                        makeRecommendedFilmsView(film: movieDetail, storedFilm: storedFilm)
                    }
                case .error:
                    Text("ERROR!!!")
                }
            }
            .toolbarBackground(gradientColor, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButtonView
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addToFavoritesButtonView
                }
            }
        }
        .onAppear {
            guard case .loading = presenter.state else { return }
            if filmDetail.first(where: { $0.filmID == self.id }) == nil {
                presenter.prepareFilmDetails(by: id ?? 0, context: context)
            } else {
                presenter.state = .data(FilmDetail())
            }
        }
    }

    private var watchButtonView: some View {
        Button {
            isWatchButtonTapped.toggle()
        } label: {
            Text("Смотреть")
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(.white)
        .frame(width: 358, height: 48)
        .background(.gradientSecond)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .alert(isPresented: $isWatchButtonTapped, content: {
            Alert(title: Text("Упс!"), message: Text("Функционал в разработке :("), dismissButton: .default(Text("Ок")))
        })
    }

    private var gradientColor: LinearGradient {
        LinearGradient(colors: [.gradientFirst, .gradientSecond], startPoint: .top, endPoint: .bottom)
    }

    private var backButtonView: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.backward")
        }
        .foregroundColor(.white)
    }

    private var addToFavoritesButtonView: some View {
        Button {
            print("add to favorites")
            isfavoritesTapped.toggle()
        } label: {
            Image(systemName: isfavoritesTapped ? "heart.fill" : "heart")
        }
        .foregroundColor(.white)
    }

    init(presenter: FilmDetailsPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    private func makeFilmPosterView(film: FilmDetail, storedFilm: SwiftDataFilmDetails? = nil) -> some View {
        HStack {
            if let image = storedFilm?.image.flatMap(UIImage.init(data:)) ?? film.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 170, height: 200)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 170, height: 200)
            }
            VStack(alignment: .leading) {
                Text(storedFilm?.filmName ?? film.filmName)
                    .font(.system(size: 18))
                    .frame(width: 150, alignment: .leading)
                    .lineLimit(5)
                    .bold()
                Text("⭐️ \(String(format: "%.1f", storedFilm?.filmRating ?? film.filmRating ?? 0.0))")
            }
            .foregroundColor(.white)
            .frame(width: 170, height: 70, alignment: .leading)
            Spacer()
        }
        .padding(.leading, 18)
    }

    private func makeCountryProductionView(film: FilmDetail, storedFilm: SwiftDataFilmDetails? = nil) -> some View {
        VStack(alignment: .leading) {
            Text(storedFilm?.filmDescription ?? film.description ?? "")
                .font(.system(size: 14))
                .lineLimit(5)
                .foregroundColor(.white)
            Spacer()
            Text(
                "\(String(storedFilm?.year ?? film.year ?? 0)) / \(storedFilm?.country ?? film.country ?? "") / \(storedFilm?.contentType ?? film.contentType ?? "")"
            )
            .font(.system(size: 14))
            .foregroundColor(.descriptionText)
        }
        .padding(.horizontal, 15)
    }

    private func makeStarringView(film: FilmDetail, storedFilm: SwiftDataFilmDetails? = nil) -> some View {
        VStack(alignment: .leading) {
            Text("Актеры и съемочная группа")
                .fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    if let storedFilm = storedFilm {
                        ForEach(storedFilm.actors, id: \.name) { actor in
                            VStack(spacing: 2) {
                                if let imageData = actor.image,
                                   let image = UIImage(data: imageData)
                                {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 50, height: 72)
                                } else {
                                    ProgressView()
                                        .frame(width: 50, height: 72)
                                }
                                Text(actor.name)
                                    .font(.system(size: 8))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 60, height: 24)
                            }
                        }
                    } else {
                        ForEach(film.actors, id: \.name) { actor in
                            VStack(spacing: 2) {
                                if let url = URL(string: actor.imageURL) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .frame(width: 50, height: 72)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 50, height: 72)
                                    }
                                }
                                Text(actor.name)
                                    .font(.system(size: 8))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 60, height: 24)
                            }
                        }
                    }
                }
            }
            Spacer()
                .frame(height: 14)
            VStack(alignment: .leading, spacing: 5) {
                Text("Язык")
                Text(storedFilm?.language ?? film.language ?? "")
                    .foregroundColor(.descriptionText)
            }
            .font(.system(size: 14))
        }
        .padding(.leading, 16)
        .foregroundColor(.white)
    }

    private func makeRecommendedFilmsView(film: FilmDetail, storedFilm: SwiftDataFilmDetails? = nil) -> some View {
        VStack(alignment: .leading) {
            Text("Смотрите также")
                .font(.system(size: 14))
                .fontWeight(.medium)
            Spacer()
                .frame(height: 12)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    let similarFilms = storedFilm?.similarFilms ?? film.similarFilms
                    ForEach(similarFilms, id: \.id) { film in
                        VStack(alignment: .leading, spacing: 8) {
                            if let url = URL(string: film.imageUrl ?? "") {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .frame(width: 170, height: 220)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 170, height: 220)
                                }
                            }
                            Text(film.filmName ?? "???")
                                .font(.system(size: 16))
                                .frame(width: 170, height: 18, alignment: .leading)
                        }
                        .padding(.trailing, 20)
                    }
                }
            }
        }
        .padding(.leading, 16)
        .foregroundColor(.white)
    }
}

#Preview {
    FilmDetailsView(presenter: FilmDetailsPresenter())
}

// swiftlint:enable all
