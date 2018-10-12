//
//  FMHRHeardCell.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/11.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import FSPagerView

protocol FMHRHeardCellDelegate: NSObjectProtocol {
    func pageViewDidSelcctAt(indepath: Int)
    
    
}

class FMHRHeardCell: UICollectionViewCell {

    weak var CellDelegate: FMHRHeardCellDelegate?
    
    private var focus:FocusModel?
    private var square:[SquareModel]?
    private var topBuzzList:[TopBuzzModel]?
    
    var focusModel:FocusModel? {
        didSet{
            guard let model = focusModel else { return }
            self.focus = model
            self.pageView.reloadData()
        }
    }
    
    var squareList:[SquareModel]? {
        didSet{
            guard let model = squareList else { return }
            self.square = model
            self.gridView.reloadData()
        }
    }
    
    var topBuzzListData:[TopBuzzModel]? {
        didSet{
            guard let model = topBuzzListData else { return }
            self.topBuzzList = model
            self.gridView.reloadData()
        }
    }
    
    // 懒加载 pageView
    lazy var pageView: FSPagerView = {
       
        let page = FSPagerView()
        //设置page
        page.dataSource = self
        page.delegate = self
        page.automaticSlidingInterval =  3
        page.isInfinite = true
        page.interitemSpacing = 15
        page.transformer = FSPagerViewTransformer(type: .linear)
        page.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return page
    }()
    
    
    let FMCollectionViewCellId = "FMCollectionViewCellId"
    let FMNewsViewCellId = "FMNewsViewCellId"
    
    lazy var gridView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        
        collectionView.register(UINib.init(nibName: "FMCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FMCollectionViewCellId)
        
        collectionView.register(FMNewsViewCell.self, forCellWithReuseIdentifier: FMNewsViewCellId)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        
        self.addSubview(self.pageView)
        self.pageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pageView.snp.bottom)
            make.height.equalTo(210)
        }
        self.pageView.itemSize = CGSize.init(width: FMScreenWidth-60, height: 140)
    }
}
// pageview的代理方法
extension FMHRHeardCell : FSPagerViewDelegate , FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
         return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.focus?.data?[index].cover)!))
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        CellDelegate?.pageViewDidSelcctAt(indepath: index)
        
    }
    
}

extension FMHRHeardCell : UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.square?.count ?? 0
        }else {
            return 1
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  indexPath.section == 0 {
            let cell:FMCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMCollectionViewCellId, for: indexPath) as! FMCollectionViewCell
            
            cell.square  =  self.square?[indexPath.row]
            return cell
        }else {
            let cell:FMNewsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMNewsViewCellId, for: indexPath) as! FMNewsViewCell
              
              cell.topBuzzList = self.topBuzzList
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize.init(width: (FMScreenWidth-5)/5, height:80)
        }else {
            return CGSize.init(width: FMScreenWidth, height: 50)
        }
    }
    
}

