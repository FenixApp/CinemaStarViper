// FilmsView.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftData
import SwiftUI

/// Вью экрана с фильмами
struct FilmsView: View {
    enum Constant {
        static let error = "Error"
    }

    @Environment(\.modelContext) var context
    @StateObject var presenter: FilmsPresenter
    @Query var swiftDataStoredFilms: [SwiftDataFilm]

    var body: some View {
        NavigationStack {
            backgroundStackView(color: gradientColor) {
                switchStateView
            }
        }
    }

    private var switchStateView: some View {
        VStack {
            switch presenter.state {
            case .loading:
                FilmsShimmerView()
            case let .data(fetchedFilms):
                if fetchedFilms.isEmpty {
                    FilmsCollectionView(swiftDataFilms: swiftDataStoredFilms)
                } else {
                    FilmsCollectionView(films: fetchedFilms)
                }
            case .error:
                Text(Constant.error)
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
