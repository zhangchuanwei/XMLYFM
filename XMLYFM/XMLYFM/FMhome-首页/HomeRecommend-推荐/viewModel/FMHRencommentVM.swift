//
//  FMHRencommentVM.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/10.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

import Moya
import SwiftyJSON
import HandyJSON

class FMHRencommentVM: NSObject {

    typealias AdddataBlock = ()->()?
    var fmhomeRecommendModel:FMHomeRecommendModel?
    
    var homeRecommendList:[HomeRecommendModel]?
    
    var recommendList : [RecommendListModel]?
    
    var focus:FocusModel?
    
    var squareList:[SquareModel]?
    
    var topBuzzList: [TopBuzzModel]?
    
    var guessYouLikeList: [GuessYouLikeModel]?
    
    var paidCategoryList: [PaidCategoryModel]?
    
    var playlist: PlaylistModel?
    
    var oneKeyListenList: [OneKeyListenModel]?
    
    var liveList: [LiveModel]?
    
    var updataBlock: AdddataBlock?
    
    
    func refreshdata()  {
        
        FMRencommentProvider.request(FMRecommendAPI.recommendList) { (result) in
            
            
            if case let .success(response) = result {
                
                let data = try? response.mapJSON()
                
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description){
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    
                    //轮播
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    //九宫选项
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [SquareModel]
                    }
                    // 听头条
                    if let topBuzz = JSONDeserializer<TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [TopBuzzModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [OneKeyListenModel]
                    }
                    
                    if let live = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [LiveModel]
                    }
                    self.updataBlock?()
                }
                
               
            }
            
           
            
        }
        
    }
    
}



extension FMHRencommentVM {
    
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return (self.homeRecommendList?.count) ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight:Int = 90
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width:FMScreenWidth,height:360)
        }else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
            return CGSize.init(width:FMScreenWidth,height:CGFloat(HeaderAndFooterHeight+180*itemNums))
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            return CGSize.init(width:FMScreenWidth,height:CGFloat(HeaderAndFooterHeight+120*count!))
        }else if moduleType == "ad" {
            return CGSize.init(width:FMScreenWidth,height:240)
        }else if moduleType == "oneKeyListen" {
            return CGSize.init(width:FMScreenWidth,height:180)
        }else {
            return .zero
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize.init(width: FMScreenWidth, height:40)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: FMScreenWidth, height: 10.0)
        }
    }
}

