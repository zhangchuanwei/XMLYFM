//
//  FMHomeViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import DNSPageView

class FMHomeViewController: UIViewController {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

     view.backgroundColor = UIColor.white
        
        
        //创建DNSPageView的style
        
        let style = DNSPageStyle()
      
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.red
        style.titleColor = UIColor.gray
        style.bottomLineColor = DominantColor
        style.bottomLineHeight = 2
        
        let  titles: [String] = ["推荐","分类","大咖VIP","直播","广播"]
        let viewControllers:[UIViewController] = [FMHomeRecomendViewController(),FMHClassityViewController(),FMHVipViewController(),FMHLiveViewController(),FMHbroadcastViewController()]
        
        // 添加成当前控制前的自控制器
        
        for vc in viewControllers {
            self.addChildViewController(vc)
        }
        
        let pages = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: FMScreenWidth, height: FMScreenHeigth-navigationBarHeight - tabBarHeight), style: style, titles: titles, childViewControllers: viewControllers)
        
        
        view.addSubview(pages)
        
       
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
