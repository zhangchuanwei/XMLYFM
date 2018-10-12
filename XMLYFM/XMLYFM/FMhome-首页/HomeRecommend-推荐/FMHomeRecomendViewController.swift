//
//  FMHomeRecomendViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
import SnapKit
class FMHomeRecomendViewController: UIViewController {

    let FMHRHeardCellId = "FMHRHeardCellId"
    let FMHomeRGussYouLikeCellId = "FMHomeRGussYouLikeCellId"
    
    lazy var viewModel : FMHRencommentVM = {
        
        return FMHRencommentVM()
        
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing =  10
        layout.itemSize = CGSize(width: (FMScreenWidth - 20) / 3, height: 110)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        let  collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        
        collection.register(FMHRHeardCell.self, forCellWithReuseIdentifier: FMHRHeardCellId)
        collection.register(FMHomeRGussYouLikeCell.self, forCellWithReuseIdentifier: FMHomeRGussYouLikeCellId)
        
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
       
       
        view.addSubview(self.collectionView)

        // 添加约束
        self.collectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }

        // 加载数据
        
        loadData()
    
    }
    
    
    func loadData() {
        
        
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
          
        }
        viewModel.refreshdata()
        
        
    }
    
}


extension FMHomeRecomendViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        
        
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell:FMHRHeardCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHRHeardCellId, for: indexPath) as! FMHRHeardCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.CellDelegate = self
            return cell
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            // 横屏排布样式
            let cell:FMHomeRGussYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHomeRGussYouLikeCellId, for: indexPath) as! FMHomeRGussYouLikeCell
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            cell.delegate = self;
            return cell
        }
        
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        return cell
        
    
        
    }
    
}


extension FMHomeRecomendViewController : FMHRHeardCellDelegate{
    func pageViewDidSelcctAt(indepath: Int) {
        
        print("点击了第几个图片",indepath)
    }
    
    
}

extension FMHomeRecomendViewController : FMHomeRGussYouLikeCellDelegate {
    
    func GussYouLikeDidSelectAt(model: RecommendListModel) {
        let vc = FMPlaytDetailViewController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
