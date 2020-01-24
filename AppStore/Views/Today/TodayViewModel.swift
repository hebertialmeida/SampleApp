//
//  TodayViewModel.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-16.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

import Foundation
import RocketData

final class TodayViewModel: CollectionViewModel<Collection> {

    override func fetchData() {
        Api.getFeaturedCollections(page: currentPage, perPage: 10) { [weak self] response in
            guard let self = self else { return }

            switch response {
            case let .success(collections):
                if self.currentPage == 1 {
                    self.dataProvider.setData(collections, cacheKey: self.cacheKey)
                    self.updateUI?(nil)
                } else {
                    self.dataProvider.append(collections, shouldCache: false)
                    let items = self.dataProvider.count - collections.count ... self.dataProvider.count - collections.count
                    debugPrint(items)
                    let changes = items.map({ CollectionChangeInformation.insert(index: $0 - 1) })
                    self.updateUI?(changes)
//                    self.updateUI?(nil)
                }
                self.currentPage += 1

            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}
