//
//  TabBarController.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import UIKit

enum TabBarItem {
    case feed
    case settings

    static func defaultItems() -> [TabBarItem] {
        return [.feed, .settings]
    }
}

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let today = TodayViewController()
        viewControllers = [today]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
