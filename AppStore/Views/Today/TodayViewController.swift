//
//  TodayViewController.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

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
        layout.headerReferenceSize = CGSize(width: 0, height: 50)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayCollectionViewCell.self, forCellWithReuseIdentifier: TodayCollectionViewCell.identifier)
        collectionView.register(TodayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodayHeaderView.identifier)
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
                        debugPrint(indexPath)
                        self.collectionView.insertItems(at: [indexPath])
                    case let .update(index):
                        let indexPath = IndexPath(row: index, section: 0)
                        self.collectionView.reloadItems(at: [indexPath])
                    }
                }
            })
        }

        viewModel.fetchData()
    }

    func setupViews() {
        view.addSubview(collectionView)

        let margins = view.safeAreaLayoutGuide
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: UICollectionViewDataSource

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsIn(section)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dataProvider.data.isEmpty ? 0 : 1
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

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayHeaderView.identifier, for: indexPath) as! TodayHeaderView

        let collection = viewModel.object(at: indexPath.row)
        let date = collection.publishedAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let monthDay: String = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        let weekday: String = dateFormatter.string(from: date)
        header.setContent(date: monthDay.uppercased(), title: weekday)
        return header
    }
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
