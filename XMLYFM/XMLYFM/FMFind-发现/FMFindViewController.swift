
//
//  FMFindViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import LTScrollView
class FMFindViewController: UIViewController {


    private lazy var headerView: FMFindHeaderView = {
        
        let view  = FMFindHeaderView.init(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: 190))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    private let  oneVc = FindAttentionViewController()
    private let  twoVc = FindAttentionViewController()
    private let  threeVc = FMPeiYinTableViewController()
    
    private lazy var viewControllers = [oneVc, twoVc, threeVc]
    
    private lazy var titles: [String] = ["关注动态","推荐关注","趣配音"]
    
    private lazy var layout: LTLayout = {
       
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        return layout
    }()
    
    private lazy var advanceManeger: LTAdvancedManager = {
       
        let advanceM = LTAdvancedManager.init(frame: CGRect(x: 0, y: navigationBarHeight, width: FMScreenWidth, height: FMScreenHeigth - navigationBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { [weak self]  in
            guard let strongSelf = self else { return UIView() }
            
              let headerView = strongSelf.headerView
              return headerView
        })
        advanceM.delegate = self
        return advanceM
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        view.addSubview(self.advanceManeger)
        advancedManagerConfig()
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
extension FMFindViewController : LTAdvancedScrollViewDelegate {
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advanceManeger.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        //        print("offset --> ", offsetY)
    }
}
