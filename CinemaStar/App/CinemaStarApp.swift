// CinemaStarApp.swift
// Copyright © RoadMap. All rights reserved.

import SwiftData
import SwiftUI
import UIKit

@main
struct CinemaStarApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ViewBuilder.buildMoviesModule()
                .modelContainer(for: [SwiftDataMovie.self, SwiftDataMovieDetail.self])
        }
    }
}
