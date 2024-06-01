// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояние  данных на экране фильмов
public enum ViewState<Model> {
    /// Данные загружаются
    case loading
    /// Есть данные
    case data(_ data: Model)
    /// ошибка
    case error
}
