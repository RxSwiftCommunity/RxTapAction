//
//  RxGesture+RxTapAction.swift
//  RxTapAction
//
//  Created by ShoichiKuraoka on 2019/04/26.
//  Copyright: All rights reserved under the MIT License.
//

import RxGesture
import RxSwift

// MARK: extesion: GestureRecognizerDelegatePolicy<(GestureRecognizer, Touch)>
extension RxGesture.GestureRecognizerDelegatePolicy where PolicyInput == (GestureRecognizer, Touch) {
    /// recognize only when touching ownerView
    static var onlyOwnerView: RxGesture.GestureRecognizerDelegatePolicy<PolicyInput> {
        return .custom { $0.view == $1.view }
    }
    
    /// always recognize except for touching argument views
    static func alwaysExcept(for exceptionalViews: [UIView]) -> RxGesture.GestureRecognizerDelegatePolicy<PolicyInput> {
        let exceptionalViewIds = exceptionalViews.map { ObjectIdentifier($0) }
        return .custom { _, touch in
            var nextComputingView: UIView? = touch.view
            while let computingView = nextComputingView {
                if exceptionalViewIds.contains(ObjectIdentifier(computingView)) {
                    return false
                } else {
                    nextComputingView = computingView.superview
                }
            }
            return true
        }
    }
}
