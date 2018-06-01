//
//  TodayViewController.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit
import SnapKit
import IGListKit

final class TodayViewController: UIViewController {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 2)
    }()

    lazy var collectionView: UICollectionView = {
        let layout = ListCollectionViewLayout(stickyHeaders: false, scrollDirection: .vertical, topContentInset: 30, stretchToEdge: false)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    var objects = [Any]()
    var currentPage = 1
    var loading = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Today", comment: "")
        tabBarItem.image = UIImage(named: "icon-tabbar-today")

        setupViews()
        fetchData(page: currentPage)
    }

    func setupViews() {
        collectionView.isPrefetchingEnabled = false
        collectionView.backgroundColor = .white
//        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }

        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self

        // Top Header
        let topHeaderView = UIVisualEffectView(frame: .zero)
        topHeaderView.effect = UIBlurEffect(style: .regular)
        topHeaderView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.insertSubview(topHeaderView, aboveSubview: collectionView)

        topHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(UIApplication.shared.statusBarFrame.height)
        }
    }

    func fetchData(page: Int) {
        loading = true

        Api.getFeaturedCollections(page: page, perPage: 10) { [weak self] response in
//        Api.getCuratedCollections(page: page, perPage: 10) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.loading = false

            switch response {
            case let .success(collections):
                guard let first = collections.first else { return }
                let list = CollectionSectionModel(id: "page\(strongSelf.currentPage)", date: first.publishedAt, collections: collections)
                let animated = strongSelf.currentPage == 1 ? true : false
                strongSelf.objects.append(list)
                strongSelf.adapter.performUpdates(animated: animated, completion: nil)
                strongSelf.currentPage += 1

            case let .failure(error):
                debugPrint(error)
            }
        }
    }
}

// MARK: ListAdapterDataSource

extension TodayViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return objects.compactMap({ ($0 as? DiffableBoxProtocol)?.asDiffableBox() })
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return CollectionSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

// MARK: UIScrollViewDelegate

extension TodayViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if !loading && distance < 300 {
            fetchData(page: currentPage)
            debugPrint("fetch \(currentPage)")
        }
    }
}
