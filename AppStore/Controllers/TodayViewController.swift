//
//  TodayViewController.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

final class TodayViewController: UIViewController {

    struct Section {
        let date: Date
        let collections: [Collection]
    }

    var collectionView: UICollectionView!
    var topHeaderView: UIVisualEffectView!
    var dataSource = [Section]()

    struct Identifier {
        static let cell = "todayCell"
        static let header = "todayHeader"
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.estimatedItemSize = CGSize(width: view.frame.width-40, height: 412)
        layout.sectionInsetReference = .fromSafeArea
        layout.minimumLineSpacing = 30

        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.cell)
        collectionView.register(TodayHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Identifier.header)
        view.addSubview(collectionView)

        // Top Header
        let navBarHeight = UIApplication.shared.statusBarFrame.height
        topHeaderView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navBarHeight))
        topHeaderView.effect = UIBlurEffect(style: .regular)
        topHeaderView.autoresizingMask = [.flexibleWidth]
        topHeaderView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.insertSubview(topHeaderView, aboveSubview: collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Today", comment: "")
        tabBarItem.image = UIImage(named: "icon-tabbar-today")

        fetchData(page: 1)
    }

    func fetchData(page: Int) {
        Api.getCuratedCollections(page: page, perPage: 5) { response in
            switch response {
            case let .success(collections):
                guard let first = collections.first else { return }
                let section = Section(date: first.publishedAt, collections: collections)
                self.dataSource.append(section)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UICollectionViewDataSource

extension TodayViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.cell, for: indexPath)

        cell.backgroundColor = .blue

        // Configure the cell
        if let c = cell as? TodayCollectionViewCell {
            c.contentView.frame = c.bounds
            c.contentView.autoresizingMask = [.flexibleWidth]
//            configureCell(c, indexPath: indexPath)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Identifier.header, for: indexPath) as? TodayHeaderView else {
            return UICollectionReusableView()
        }

        header.setContent(date: "Tuesday, May 29".uppercased(), title: "Today")
        return header
    }
}

// MARK: UICollectionViewDelegate

extension TodayViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("")
    }
}

extension TodayViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let top: CGFloat = section == 0 ? 10 : 20
        return UIEdgeInsets(top: top, left: 0, bottom: 60, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height: CGFloat = section == 0 ? 58 : 54
        return CGSize(width: view.frame.width, height: height)
    }
}
