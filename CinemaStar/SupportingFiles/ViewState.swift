// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояние данных на экране с фильмами
public enum ViewState<Model> {
    /// Загрузка данных
    case loading
    /// Данные загружены
    case data(_ data: Model)
    /// Ошибка
    case error
}
