//
//  FMHClassityCell.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/10.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

class FMHClassityCell: UICollectionViewCell {

    
    @IBOutlet weak var iamgeLeft: NSLayoutConstraint!
    @IBOutlet weak var iamgeW: NSLayoutConstraint!
    
    @IBOutlet weak var labLeft: NSLayoutConstraint!
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var itemModel: itemList?  {
        
        didSet{
            
            guard let model = itemModel else { return }
            if model.itemType == 1 {// 如果是第一个item,是有图片显示的，并且字体偏小
                self.iamgeW.constant = 0
                self.iamgeLeft.constant = 0
                self.contentLab.text = model.itemDetail?.keywordName
                self.contentLab.textAlignment = .center
                
            }else{
                self.iamgeW.constant = 25
                
                self.iamgeLeft.constant = 8
                self.contentLab.textAlignment = .left
                self.contentLab.text = model.itemDetail?.title
                self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            }
            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    

}
