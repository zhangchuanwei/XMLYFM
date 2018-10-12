//
//  FMHClassityModel.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

import HandyJSON


struct HClassityModel : HandyJSON {
    var ret: Int = 0
    var code: String?
    var msg: String?
    var list: [ClassityModel]?
 
}

struct ClassityModel : HandyJSON {
    
    var groupName: String?
    
    var displayStyleType = 0
    
    var  itemList:[itemList]?
    
}


struct itemList : HandyJSON{
    var coverPath: String?
    
    var isDisplayCornerMark: Bool?
    
    var itemDetail : itemDetail?
    
    var itemType: Int = 0
    
}
struct itemDetail: HandyJSON {
    var title: String?
    
    var keywordName: String?
    
    var categoryType: Int = 0
    
    var filterSupported: Bool?
    
    var moduleType: Int = 0
    
    var categoryId: Int = 0
    
    var name : String?

}

