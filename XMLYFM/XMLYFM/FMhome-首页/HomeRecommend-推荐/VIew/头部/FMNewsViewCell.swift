//
//  FMNewsViewCell.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/11.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

class FMNewsViewCell: UICollectionViewCell {
    
    private var topBuzz:[TopBuzzModel]?
    
    var topBuzzList:[TopBuzzModel]? {
        didSet{
            guard let model = topBuzzList else { return }
            self.topBuzz = model
            self.collectionView.reloadData()
        }
    }
    lazy var imageView: UIImageView = {
       
        let imagev = UIImageView(frame: CGRect.zero)
        imagev.image = UIImage(named: "news")
        
        return imagev
        
    }()
    
    // 定时器
     var timer: Timer?
    lazy var moreBtn: UIButton = {
      
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("|  更多", for: UIControlState.normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (FMScreenWidth-150), height:40)
        let collectionView = UICollectionView.init(frame:CGRect(x:80,y:5, width:FMScreenWidth-150, height:40), collectionViewLayout: layout)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionView.contentSize = CGSize(width: (FMScreenWidth-150), height: 40)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier:"NewsCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.collectionView)
        self.addSubview(self.moreBtn)
        
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(5)
        }
        
        startTime()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

extension FMNewsViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.topBuzz?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:NewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.titleLabel.text = self.topBuzzList?[indexPath.row%(self.topBuzz?.count)!].title
        return cell
    }
    
    
    func startTime()  {
        
        let  timer = Timer.init(timeInterval: 3, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: .commonModes)
        self.timer = timer
    }
    
    @objc func nextPage()  {
        let currentOffsetY = collectionView.contentOffset.y
        let offsetY = currentOffsetY + collectionView.bounds.height
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
    
    
}


class NewsCell: UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.height.top.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
