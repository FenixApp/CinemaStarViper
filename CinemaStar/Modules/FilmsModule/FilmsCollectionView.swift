// FilmsCollectionView.swift

import Combine
import SwiftData
import SwiftUI

/// Вью с коллекцией фильмов
struct FilmsCollectionView: View {
    enum Constant {
        static let logoText = "Смотри исторические\nфильмы на "
        static let boldLogoText = "CINEMA STAR"
        static let format = "%.1f"
    }

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
                Text(Constant.logoText)
                    +
                    Text(Constant.boldLogoText)
                    .fontWeight(.heavy)
            }
            .padding(.horizontal)
            scrollView
        }
    }

    private var scrollView: some View {
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
                                Text("⭐️ \(String(format: Constant.format, film.rating ?? 0.0))")
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

#Preview {
    FilmsView(presenter: FilmsPresenter())
}
