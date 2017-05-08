//
//  NavigationController.swift
//  UITester
//
//  Copyright (c) 2015-present Peng Wang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    @objc private func showCollection(_ sender: Any?) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CollectionViewController")
        pushViewController(viewController, animated: true)
    }

}
