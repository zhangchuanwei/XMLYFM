//
//  FMListenViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import LTScrollView
class FMListenViewController: UIViewController {

    
    
    private  lazy var headView: UIView = {
       
        let head = UIView(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: 120))
        head.backgroundColor = UIColor.red
        return head
    }()
 
    private lazy var titles: [String] = {
        return [ "一键听","订阅", "推荐"]
    }()
    
    lazy var viewControllers: [UIViewController] = {
       
        let oneVc = FMOneKekListenTableViewController()
        let twoVc = UIViewController()
        let threeVc = UIViewController()
        return [oneVc, twoVc, threeVc]
    }()
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    private lazy var advanceManager : LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: navigationBarHeight , width: FMScreenWidth, height: FMScreenHeigth - navigationBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout:layout , headerViewHandle: { [weak self] in
            
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headView
            return headerView
        })
        
        advancedManager.delegate = self
        return advancedManager
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advanceManager)
        advancedManagerConfig()
        // Do any additional setup after loading the view.
    }
    

   

}
extension FMListenViewController : LTAdvancedScrollViewDelegate {
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advanceManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        //        print("offset --> ", offsetY)
    }
}
