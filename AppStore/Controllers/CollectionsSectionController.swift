//
//  CollectionsSectionController.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-31.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import IGListKit

final class CollectionSectionController: ListSectionController {

    private var dataSource: CollectionSectionModel!

    override init() {
        super.init()
        supplementaryViewSource = self
        minimumLineSpacing = 30
        inset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    }

    override func numberOfItems() -> Int {
        return dataSource.collections.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width-40, height: 412)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: TodayCollectionViewCell.self, for: self, at: index) as? TodayCollectionViewCell else {
            return UICollectionViewCell()
        }

        let collection = dataSource.collections[index]
        let photo = collection.coverPhoto

        cell.setContent(
            imageUrl: photo.urls.regular,
            label: "Curated by \(collection.user.name)".uppercased(),
            title: collection.title,
            description: collection.description ?? "",
            color: UIColor(photo.color)
        )
        return cell
    }

    override func didUpdate(to object: Any) {
        dataSource = (object as? DiffableBox<CollectionSectionModel>)?.value
    }

    override func didSelectItem(at index: Int) {
        debugPrint("Did select")
    }
}

extension CollectionSectionController: ListSupplementaryViewSource {
    func supportedElementKinds() -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }

    func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
        guard let header = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: self, class: TodayHeaderView.self, at: index) as? TodayHeaderView else {
            return UICollectionReusableView()
        }

        let date = dataSource.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let monthDay: String = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        let weekday: String = dateFormatter.string(from: date)
        header.setContent(date: monthDay.uppercased(), title: weekday)
        return header
    }

    func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
        let height: CGFloat = section == 0 ? 68 : 74
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }
}
