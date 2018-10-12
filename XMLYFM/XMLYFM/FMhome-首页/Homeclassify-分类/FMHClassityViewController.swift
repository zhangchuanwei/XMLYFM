//
//  FMHClassityViewController.swift
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
class FMHClassityViewController: UIViewController {
    
    
    let FMHClassityCellId = "FMHClassityCellId"
    
    
    lazy var viewModel: FMHClassityVM = {
        
        return FMHClassityVM()
        
    }()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing =  10
//        layout.itemSize = CGSize(width: (FMScreenWidth - 20) / 3, height: 110)
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        let  collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        
        collection.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        collection.register(UINib.init(nibName: "FMHClassityCell", bundle: nil), forCellWithReuseIdentifier: FMHClassityCellId)
        collection.backgroundColor = FooterViewColor
        
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
        // Do any additional setup after loading the view.
    }
    func loadData() {
        
        
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
            
        }
        viewModel.refreshDataSource()
        
        
    }
   
}
extension FMHClassityViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
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
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHClassityCellId, for: indexPath) as! FMHClassityCell
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.itemModel = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row]
        return cell
    }
    
}
