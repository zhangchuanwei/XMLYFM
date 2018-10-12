//
//  FMRencommentApi.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/10.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

import Moya

let FMRencommentProvider = MoyaProvider<FMRecommendAPI>()

enum FMRecommendAPI {
    case recommendList//推荐列表
    case recommendForYouList // 为你推荐
    case recommendAdList // 推荐页面穿插的广告
    case guessYouLikeMoreList // 猜你喜欢更多
}

extension FMRecommendAPI: TargetType  {
    var baseURL: URL {
        switch self {
        case .recommendAdList:
            return URL(string: "http://adse.ximalaya.com")!
        default:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .recommendList: return "/discovery-firstpage/v2/explore/ts-1532411485052"
        case .recommendForYouList: return "/mobile/discovery/v4/recommend/albums"
        case .recommendAdList: return "/ting/feed/ts-1532656780625"
        case .guessYouLikeMoreList: return "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
        
        }
    }
    
    var method: Moya.Method { return .get }
    
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .recommendList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "categoryId":-2,
                "channel":"ios-b1",
                "code":"43_310000_3100",
                "includeActivity":true,
                "includeSpecial":true,
                "network":"WIFI",
                "operator":3,
                "pullToRefresh":true,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .recommendForYouList:
            parmeters = [
                "device":"iPhone",
                "excludedAlbumIds":"3144231%2C3160816%2C5088879%2C3703879%2C9723091%2C12580785%2C12610571%2C13507836%2C11501536%2C12642314%2C4137349%2C10587045%2C6233693%2C4436043%2C16302530%2C15427120%2C13211141%2C61%2C220565%2C3475911%2C3179882%2C10596891%2C261506%2C7183288%2C203355%2C3493173%2C7054736%2C10728301%2C2688602%2C13048404",
                "appid":0,
                "categoryId":-2,
                "pageId":1,
                "pageSize":20,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case .recommendAdList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "name":"find_native",
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970)
            ]
            /*
             http://mobile.ximalaya.com/discovery-firstpage/guessYouLike/list/ts-1534815616591?appid=0&device=iPhone&deviceId=5DC0EF2A-01F6-41D1-8455-C4A1BF927E36&inreview=false&network=WIFI&operator=3&pageId=1&pageSize=20&scale=3&uid=124057809&version=6.5.3&xt=1534815616592%20HTTP/1.1
             */
        case .guessYouLikeMoreList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":20,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        
        }
        
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
    
    
    
}



