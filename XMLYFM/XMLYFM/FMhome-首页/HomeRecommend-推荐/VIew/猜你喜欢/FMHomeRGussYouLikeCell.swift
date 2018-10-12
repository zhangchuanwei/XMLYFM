//
//  FMHomeRGussYouLikeCell.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/11.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

protocol FMHomeRGussYouLikeCellDelegate: NSObjectProtocol {
    
   func GussYouLikeDidSelectAt(model: RecommendListModel)
    
}

class FMHomeRGussYouLikeCell: UICollectionViewCell {
    let FMGuessYouLikeCellID = "FMGuessYouLikeCellID"
    
    weak var delegate: FMHomeRGussYouLikeCellDelegate?
    private var recommendList:[RecommendListModel]?
    var recommendListData:[RecommendListModel]? {
        didSet{
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(FMGussYouLikeCell.self, forCellWithReuseIdentifier: FMGuessYouLikeCellID)
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    
    func  setUpUI()  {
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



extension FMHomeRGussYouLikeCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:FMGussYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMGuessYouLikeCellID, for: indexPath) as! FMGussYouLikeCell
        
        cell.recommendData = self.recommendList?[indexPath.row]
        
        return cell ;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
       delegate?.GussYouLikeDidSelectAt(model: (self.recommendList?[indexPath.row])!)
        
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(FMScreenWidth-55)/3,height:180)
    }
    
    
}
