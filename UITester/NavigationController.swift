//
//  NavigationController.swift
//  UITester
//
//  Copyright (c) 2015-present Peng Wang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        switch action {
        case #selector(showCollection(_:)):
            return sender is UICollectionViewCell || presentingViewController != nil
        case #selector(dismissCollection(_:)):
            return (presentedViewController as? NavigationController)?.topViewController is CollectionViewController
        default: return responds(to: action)
        }
    }

    @objc private func dismissCollection(_ sender: Any?) {
        dismiss(animated: true)
    }

    @objc private func showCollection(_ sender: Any?) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CollectionViewController")
        if sender is UICollectionViewCell {
            pushViewController(viewController, animated: true)
        } else {
            assert(presentingViewController != nil)
            present(NavigationController(rootViewController: viewController), animated: true)
        }
    }

}
