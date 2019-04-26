//
//  UICollectionView+RxTapAction.swift
//  RxTapAction
//
//  Created by ShoichiKuraoka on 2019/04/26.
//  Copyright: All rights reserved under the MIT License.
//

import RxCocoa
import RxSwift

public extension UICollectionView {
    enum HighlightActionType {
        case darken, lighten, shrink
    }
}

public extension Reactive where Base: UICollectionView {
    func highlightAction(_ highlightActionType: UICollectionView.HighlightActionType) -> Disposable {
        return highlightAction { _ in highlightActionType }
    }
    
    func highlightAction(_ highlightActionType: @escaping ((IndexPath) -> UICollectionView.HighlightActionType)) -> Disposable {
        var disposables = [Disposable]()
        disposables += [itemHighlighted.bind { indexPath in
            switch highlightActionType(indexPath) {
            case .darken: self.base.add(kSharedDarkView, indexPath: indexPath)
            case .lighten: self.base.add(kSharedLightView, indexPath: indexPath)
            case .shrink: self.base.transformShrinkCell(indexPath: indexPath)
            }
            }
        ]
        disposables += [itemUnhighlighted.bind { indexPath in
            switch highlightActionType(indexPath) {
            case .darken: self.base.remove(kSharedDarkView, indexPath: indexPath)
            case .lighten: self.base.remove(kSharedLightView, indexPath: indexPath)
            case .shrink: self.base.transformOriginalCell(indexPath: indexPath)
            }
            }
        ]
        return Disposables.create(disposables)
    }
}

private extension UICollectionView {
    func add(_ coverView: UIView, indexPath: IndexPath) {
        guard let cell = cellForItem(at: indexPath), coverView.superview !== cell else {
            return
        }
        coverView.removeFromSuperview()
        coverView.isHidden = true
        cell.addSubview(coverView)
        coverView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        coverView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        coverView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        coverView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        coverView.isHidden = false
    }
    
    func remove(_ coverView: UIView, indexPath: IndexPath) {
        guard let cell = cellForItem(at: indexPath), coverView.superview === cell else {
            return
        }
        coverView.removeFromSuperview()
    }
    
    func transformShrinkCell(indexPath: IndexPath) {
        let shrinkedTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        guard let cell = cellForItem(at: indexPath), cell.transform != shrinkedTransform else {
            return
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            cell.transform = shrinkedTransform
        })
    }
    
    func transformOriginalCell(indexPath: IndexPath) {
        let standardTransform = CGAffineTransform(scaleX: 1, y: 1)
        guard let cell = cellForItem(at: indexPath), cell.transform != standardTransform else {
            return
        }
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            cell.transform = standardTransform
        })
    }
}

private let kSharedDarkView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.alpha = 0.2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()

private let kSharedLightView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.alpha = 0.2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()
