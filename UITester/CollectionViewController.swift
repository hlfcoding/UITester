//
//  CollectionViewController.swift
//  UITester
//
//  Copyright (c) 2015-present Peng Wang. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
            navigationItem.title = navigationItem.title?
                .appending(": L\(String(describing: navigationController.viewControllers.count))")
        }
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.isAccessibilityElement = true
        cell.accessibilityLabel = "Cell at section \(indexPath.section) item \(indexPath.item)"
        return cell
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "CollectionViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }

}
