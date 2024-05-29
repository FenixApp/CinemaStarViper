// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///// Состояние загрузки данных
// enum ViewState<Model> {
//    /// Загрузка данных
//    case loading
//    /// Данные загружены
//    case data(Model)
//    /// Данных отсутствуют
//    case noData
//    /// Ошибка
//    case error(_ error: Error)
// }

/// Состояние  данных на экране фильмов
public enum ViewState<Model> {
    /// Данные загружаются
    case loading
    /// Есть данные
    case data(_ data: Model)
    /// ошибка
    case error
}
