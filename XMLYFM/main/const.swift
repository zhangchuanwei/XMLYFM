//
//  const.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//
import UIKit
import Foundation
let kNavBarBottom = WRNavigationBar.navBarBottom()
let  FMScreenWidth: CGFloat = UIScreen.main.bounds.size.width
let  FMScreenHeigth: CGFloat = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)

// iphone X
let isIphoneX = FMScreenHeigth == 812 ? true : false
// navigationBarHeight
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49


let baseUrl = "http://mobile.ximalaya.com"

