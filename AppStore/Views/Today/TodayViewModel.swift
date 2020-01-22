//
//  TodayViewModel.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-16.
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

final class TodayViewModel: CollectionViewModel<Collection> {

    override func fetchData() {
        Api.getFeaturedCollections(page: currentPage, perPage: 10) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case let .success(collections):
                if self.currentPage == 1 {
                    self.dataProvider.setData(collections, cacheKey: self.cacheKey)
                } else {
                    self.dataProvider.append(collections, shouldCache: false)
                }
                self.currentPage += 1
                self.updateUI?(nil)
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
