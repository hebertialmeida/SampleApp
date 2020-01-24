//
//  CollectionViewModel.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-23.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

import Foundation
import RocketData

class CollectionViewModel<T: SimpleModel> {

    var cacheKey: String
    var currentPage = 1
    var updateUI: (([CollectionChangeInformation]?) -> ())?

    lazy var dataProvider = CollectionDataProvider<T>()

    init(cacheKey: String) {
        self.cacheKey = cacheKey
        dataProvider.delegate = self
        dataProvider.fetchDataFromCache(withCacheKey: cacheKey) { (collections, error) in
            self.updateUI?(nil)
        }
    }

    // MARK: Networking and data

    func fetchData() { }

    // MARK: CollectionView

    func numberOfItemsIn(_ section: Int) -> Int {
        return dataProvider.count
    }

    func object(at index: Int) -> T {
        return dataProvider[index]
    }

    @objc func refreshData() {
        currentPage = 1
        fetchData()
    }
}

extension CollectionViewModel: CollectionDataProviderDelegate {
    func collectionDataProviderHasUpdatedData<T>(_ dataProvider: CollectionDataProvider<T>, collectionChanges: CollectionChange, context: Any?) where T : SimpleModel {
        switch collectionChanges {
        case let .changes(changeInfo):
            self.updateUI?(changeInfo)
        case .reset:
            self.updateUI?(nil)
        }
    }
}
