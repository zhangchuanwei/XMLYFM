//
//  FMClassSubMenuViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/16.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView
class FMClassSubMenuViewController: UIViewController {

    var categoryId: Int = 0
    private var isVipPush:Bool = false
    private var Keywords:[ClassifySubMenuKeywords]?
    private lazy var nameArray = NSMutableArray()
    private lazy var keywordIdArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        ClassifySubMenuProvider.request(.headerCategoryList(categoryId: self.categoryId)) { (Result) in
            
            if case let .success(response) = Result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) { // 从字符串转换为对象实例
                    self.Keywords = mappedObject as? [ClassifySubMenuKeywords]
                    for keyword in self.Keywords! {
                        self.nameArray.add(keyword.keywordName!)
                    }
                    if !self.isVipPush{
                        self.nameArray.insert("推荐", at: 0)
                    }
                   
                    self.initHeardview()
                }
            }
        }
    }
    
    func initHeardview() {
        
        let style =  DNSPageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = DominantColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = FooterViewColor
        
        var viewControllers = [UIViewController]()
        for keyword in self.Keywords! {
            let controller = FMClassSubMenuTableViewController()
            viewControllers.append(controller)
        }
        
        if !self.isVipPush {
            let categoryId = self.Keywords?.last?.categoryId
            viewControllers.insert(FMClassRecommentViewController(), at: 0)
        }
        // 添加contentVC
        for vc in viewControllers{
            self.addChildViewController(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: FMScreenWidth, height: FMScreenHeigth-navigationBarHeight), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
        
    }
    
    
    
}
