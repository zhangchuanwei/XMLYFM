//
//  FMHClassityVM.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class FMHClassityVM: NSObject {
   var classifyModel:[ClassityModel]?
//    typealias(别名)  这里的用法相当于OC中的 typedef
    // typealias 是用来为已经存在的类型重新定义名字的，通过命名，可以使代码变得更加清晰。
    typealias addDatabBlock = () -> Void
    
    var updataBlock: addDatabBlock?

}

extension FMHClassityVM {
    
    func refreshDataSource()  {
        
        HomeClassifProvider.request(.clssifyList) { (result) in
           
            if case let .success(response) = result  {
                 let data = try? response.mapJSON()
                 let json = JSON(data!)
                
            
                if let mappedObject = JSONDeserializer<HClassityModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.classifyModel = mappedObject.list
                }
                self.updataBlock?()
            }
        }
    }
}

// 数据

extension FMHClassityVM {
    
    
    func numberOfSections(collectionView:UICollectionView) ->Int {
        
    return self.classifyModel?.count ?? 0
        
        
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 2
    }
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:(FMScreenWidth-10)/4,height:40)
        }else {
            return CGSize.init(width:(FMScreenWidth-7.5)/3,height:40)
        }
    }
    
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize.init(width: FMScreenWidth, height:30)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: FMScreenWidth, height: 8.0)
    }
}




