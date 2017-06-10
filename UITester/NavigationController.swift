//
//  NavigationController.swift
//  UITester
//
//  Copyright (c) 2015-present Peng Wang. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

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

extension NavigationController: UINavigationControllerDelegate {

    class Animator: NSObject, UIViewControllerAnimatedTransitioning {

        let isReverse: Bool

        init(isReverse: Bool) {
            self.isReverse = isReverse
            super.init()
        }

        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.3
        }

        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            let from = transitionContext.viewController(forKey: .from)!
            let to = transitionContext.viewController(forKey: .to)!
            if isReverse {
                transitionContext.containerView.insertSubview(to.view, belowSubview: from.view)
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    from.view.alpha = 0
                }) { finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            } else {
                to.view.alpha = 0
                transitionContext.containerView.addSubview(to.view)
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    to.view.alpha = 1
                }) { finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }
        
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator(isReverse: operation == .pop)
    }

}
