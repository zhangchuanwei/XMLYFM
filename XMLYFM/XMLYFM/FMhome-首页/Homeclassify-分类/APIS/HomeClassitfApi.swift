//
//  HomeClassitfApi.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import Foundation
import Moya
import HandyJSON


//想要成为请求的提供者 就要遵循moya的协议
let HomeClassifProvider = MoyaProvider<HomeClassifyApi>()

//
// 请求分类
public enum HomeClassifyApi {
    
    case clssifyList
}

extension HomeClassifyApi : TargetType {
    
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .clssifyList:
            return URL(string: baseUrl)!
        }
    }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .clssifyList:
            return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1"
        }
    }
    //请求类型
    public var method: Moya.Method {
         return .get
    }
   
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .clssifyList:
            return .requestPlain
        }
    }
    //请求头
    public var headers: [String : String]? {
         return nil
    }
    
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        
        return "{}".data(using: String.Encoding.utf8)!
        
    }
    
    
}


