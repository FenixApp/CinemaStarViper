// MoviesDetailView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

///  Протокол для взаимодействия с вью
protocol MoviesDetailViewProtocol {}

/// Вью экрана с детальным фильмом
struct MoviesDetailView: View, MoviesDetailViewProtocol {
    @StateObject var presenter: MoviesDetailPresenter
    @Environment(\.dismiss) var dismiss
    @State var isfavoritesTapped = false
    @State var isWatchButtonTapped = false

    var id: Int?

    var body: some View {
        backgroundStackView(color: gradientColor) {
            ScrollView(showsIndicators: false) {
                switch presenter.state {
                case .loading:
                    Text("loading")
                case let .data(movieDetail):
                    VStack {
                        makeMoviePosterView(movie: movieDetail)
                        Spacer()
                            .frame(height: 16)
                        watchButtonView
                        Spacer()
                            .frame(height: 16)
                        makeCountryProductionView(movie: movieDetail)
                        Spacer()
                            .frame(height: 16)
                        makeStarringView(movie: movieDetail)
                        Spacer()
                            .frame(height: 10)
                        makeRecommendedMoviesView(movie: movieDetail)
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
            presenter.prepareMovieDetails(by: id ?? 0)
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

    init(presenter: MoviesDetailPresenter) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    private func makeMoviePosterView(movie: MovieDetail) -> some View {
        HStack {
            if let image = movie.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 170, height: 200)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 170, height: 200)
            }
            VStack(alignment: .leading) {
                Text(movie.movieName)
                    .font(.system(size: 18))
                    .frame(width: 100)
                    .bold()
                Text("⭐️ \(String(format: "%.1f", movie.movieRating ?? 0.0))")
            }
            .foregroundColor(.white)
            .frame(width: 170, height: 70, alignment: .leading)
            Spacer()
        }
        .padding(.leading, 18)
    }

    private func makeCountryProductionView(movie: MovieDetail) -> some View {
        VStack(alignment: .leading) {
            Text(movie.description ?? "")
                .font(.system(size: 14))
//                                        .frame(width: 330, alignment: .leading)
                .lineLimit(5)
                .foregroundColor(.white)
            Spacer()
            Text("\(String(movie.year ?? 0)) / \(movie.country ?? "") / \(movie.contentType ?? "")")
                .font(.system(size: 14))
                .foregroundColor(.descriptionText)
        }
        .padding(.horizontal, 15)
    }

    private func makeStarringView(movie: MovieDetail) -> some View {
        VStack(alignment: .leading) {
            Text("Актеры и сьемочная группа")
                .fontWeight(.medium)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(movie.actors, id: \.name) { actor in
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
            Spacer()
                .frame(height: 14)
            VStack(alignment: .leading, spacing: 5) {
                Text("Язык")
                Text(movie.language ?? "")
                    .foregroundColor(.descriptionText)
            }
            .font(.system(size: 14))
        }
        .padding(.leading, 16)
        .foregroundColor(.white)
    }

    private func makeRecommendedMoviesView(movie: MovieDetail) -> some View {
        VStack(alignment: .leading) {
            Text("Смотрите также")
                .font(.system(size: 14))
                .fontWeight(.medium)
            Spacer()
                .frame(height: 12)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(movie.similarMovies, id: \.id) { movie in
                        VStack(alignment: .leading, spacing: 8) {
                            if let url = movie.imageUrl {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .frame(width: 170, height: 220)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 170, height: 200)
                                }
                            }
                            Text(movie.movieName ?? "???")
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
    MoviesDetailView(presenter: MoviesDetailPresenter())
}
