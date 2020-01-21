//
//  TodayViewModel.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-16.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

import Foundation

class CollectionViewModel<T> {

    var updateUI: ((_ old: [T], _ new: [T]) -> ())?

    var dataSource = [T]() {
        didSet { updateUI?(oldValue, dataSource) }
    }

    var currentPage = 1

    // MARK: Networking and data

    func fetchData() {
    }

    // MARK: CollectionView

    func numberOfItemsIn(_ section: Int) -> Int {
        return dataSource.count
    }

    func cellViewModel(at index: Int) -> T {
        return dataSource[index]
    }
}

final class TodayViewModel: CollectionViewModel<Collection> {

    override func fetchData() {
        Api.getFeaturedCollections(page: currentPage, perPage: 10) { [weak self] response in
            switch response {
            case let .success(collections):
                self?.dataSource.append(contentsOf: collections)
                self?.currentPage += 1
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    @objc func refreshData() {
        currentPage = 1
        fetchData()
    }
}
