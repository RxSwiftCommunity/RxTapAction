//
//  ViewController.swift
//  RxTapAction
//
//  Created by Meng Li on 04/26/2019.
//  Copyright (c) 2019 lm2343635. All rights reserved.
//

import UIKit
import RxSwift
import RxTapAction
import SnapKit

class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: 60, height: 60)
            layout.scrollDirection = .horizontal
            return layout
        }())
        collectionView.register(cellType: CollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.rx.itemSelected.bind { [unowned self] in
            self.viewModel.pick(at: $0.row)
        }.disposed(by: disposeBag)
        collectionView.rx.highlightAction(.darken).disposed(by: disposeBag)
        return collectionView
    }()
    
    private lazy var dataSource = CollectionViewSingleSectionDataSource<String>(configureCell: { _, collectionView, indexPath, title in
        let cell = collectionView.dequeueReusableCell(for: indexPath) as CollectionViewCell
        cell.title = title
        return cell
    })
    
    private let disposeBag = DisposeBag()
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        viewModel.itemSection.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }

}

