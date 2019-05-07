//
//  ViewModel.swift
//  RxTapAction_Example
//
//  Created by Meng Li on 2019/05/07.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import RxSwift
import RxCocoa

class ViewModel {
    
    private let items = Array(1...10)
    
    var itemSection: Observable<SingleSection<String>> {
        return Observable.just(items.map { String($0) }).map { SingleSection.create($0) }
    }
    
    func pick(at index: Int) {
        
    }
    
}
