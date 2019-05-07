//
//  UIView+RxTapAction.swift
//  RxTapAction
//
//  Created by ShoichiKuraoka on 2019/04/26.
//  Copyright: All rights reserved under the MIT License.
//

import RxCocoa
import RxGesture
import RxSwift

extension Reactive where Base: UIView {
    
    public typealias ButtonLikeAction = (_ baseView: UIView, _ tapped: Bool) -> Void
    
    public enum ButtonLikeActionType {
        case darken
        case lighten
        case shrink
        case custom(action: ButtonLikeAction)
    }
    
    public func addButtonLikeAction(_ type: ButtonLikeActionType = .darken, exceptionalViews: [UIView] = []) -> Disposable {
        switch type {
        case .darken: return addCoverActionGesture(coverView: kSharedDarkView, exceptionalViews: exceptionalViews)
        case .lighten: return addCoverActionGesture(coverView: kSharedLightView, exceptionalViews: exceptionalViews)
        case .shrink: return addShrinkActionGesture(exceptionalViews: exceptionalViews)
        case .custom(let action): return addCustomButtonLikeGesture(exceptionalViews: exceptionalViews, action: action)
        }
    }
    
    // MARK: Private
    private func addCustomButtonLikeGesture(exceptionalViews: [UIView], action: @escaping ButtonLikeAction) -> Disposable {
        var disposables = [Disposable]()
        let baseView = base
        disposables += [baseView.rx
            .longPressGesture {
                $0.minimumPressDuration = 0
                $1.touchReceptionPolicy = .alwaysExcept(for: exceptionalViews)
            }
            .when(.began)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(onNext: { [weak baseView] _ in
                guard let baseView = baseView else { return }
                action(baseView, true)
            })]
        disposables += [baseView.rx
            .anyGesture(
                (.longPress {
                    $0.minimumPressDuration = 0
                    $1.touchReceptionPolicy = .alwaysExcept(for: exceptionalViews)
                    },
                 when: .ended),
                (.pan { $1.touchReceptionPolicy = .alwaysExcept(for: exceptionalViews) }, when: .began),
                (.tap { $1.touchReceptionPolicy = .alwaysExcept(for: exceptionalViews) }, when: .recognized)
            )
            .asDriver()
            .drive(onNext: { [weak baseView] _ in
                guard let baseView = baseView else { return }
                action(baseView, false)
            })]
        return Disposables.create(disposables)
    }
    
    private func addCoverActionGesture(coverView: UIView, exceptionalViews: [UIView]) -> Disposable {
        return self.addCustomButtonLikeGesture(exceptionalViews: exceptionalViews) { baseView, tapped in
            if tapped {
                guard coverView.superview !== baseView else { return }
                coverView.removeFromSuperview()
                coverView.isHidden = true
                baseView.addSubview(coverView)
                coverView.topAnchor.constraint(equalTo: baseView.topAnchor).isActive = true
                coverView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
                coverView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
                coverView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor).isActive = true
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    coverView.isHidden = false
                })
            } else {
                guard coverView.superview === baseView else { return }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    coverView.isHidden = true
                }, completion: { finished in
                    guard finished, coverView.superview === baseView else { return }
                    coverView.removeFromSuperview()
                })
            }
        }
    }
    
    private func addShrinkActionGesture(exceptionalViews: [UIView]) -> Disposable {
        return self.addCustomButtonLikeGesture(exceptionalViews: exceptionalViews) { baseView, tapped in
            if tapped {
                let shrinkedTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                guard baseView.transform != shrinkedTransform else { return }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    baseView.transform = shrinkedTransform
                })
            } else {
                let standardTransform = CGAffineTransform(scaleX: 1, y: 1)
                guard baseView.transform != standardTransform else { return }
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    baseView.transform = standardTransform
                })
            }
        }
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
