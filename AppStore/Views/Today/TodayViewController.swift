//
//  TodayViewController.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit
import SnapKit

enum Section {
  case collections
}

final class TodayViewController: UIViewController {

    let viewModel = TodayViewModel(cacheKey: "todayCollection")

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width-40, height: 412)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: TodayCollectionViewCell.identifier)
        return collectionView
    }()

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Today", comment: "")
        tabBarItem.image = UIImage(named: "icon-tabbar-today")

        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(viewModel, action: #selector(TodayViewModel.refreshData), for: .valueChanged)

        setupViews()
        bindViewModel()
    }

    func bindViewModel() {
        viewModel.updateUI = { changes in
            defer { self.collectionView.refreshControl?.endRefreshing() }

            guard let changes = changes else {
                self.collectionView.reloadData()
                return
            }

            self.collectionView.performBatchUpdates({
                changes.forEach { change in
                    switch change {
                    case let .delete(index):
                        let indexPath = IndexPath(row: index, section: 0)
                        self.collectionView.deleteItems(at: [indexPath])
                    case let .insert(index):
                        let indexPath = IndexPath(row: index, section: 0)
                        self.collectionView.insertItems(at: [indexPath])
                    case let .update(index):
                        let indexPath = IndexPath(row: index, section: 0)
                        self.collectionView.reloadItems(at: [indexPath])
                    }
                }
            })

            self.collectionView.refreshControl?.endRefreshing()

        }

        viewModel.fetchData()
    }

    func setupViews() {
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }

        // Top Header
        let topHeaderView = UIView(frame: .zero)
        topHeaderView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.insertSubview(topHeaderView, aboveSubview: collectionView)

        topHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        }
    }
}

// MARK: UICollectionViewDataSource

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsIn(section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCollectionViewCell.identifier, for: indexPath) as! TodayCollectionViewCell
        let collection = viewModel.object(at: indexPath.row)
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
}

// MARK: UICollectionViewDelegate

extension TodayViewController: UICollectionViewDelegate {

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayHeaderView.identifier, for: indexPath) as! TodayHeaderView
//
//        let collection = viewModel.dataSource[indexPath.row]
//        collection
//        let date = dataSource.date
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM dd"
//        let monthDay: String = dateFormatter.string(from: date)
//        dateFormatter.dateFormat = "EEEE"
//        let weekday: String = dateFormatter.string(from: date)
//        header.setContent(date: monthDay.uppercased(), title: weekday)
//        return header
//    }

}

// MARK: UIScrollViewDelegate

extension TodayViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if distance < scrollView.bounds.height {
            viewModel.fetchData()
        }
    }
}
