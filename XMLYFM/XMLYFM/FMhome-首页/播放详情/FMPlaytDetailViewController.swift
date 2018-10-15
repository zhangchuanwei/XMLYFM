//
//  FMPlaytDetailViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/12.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON
class FMPlaytDetailViewController: UIViewController {

    
//    便利构造器
    //便利构造器，只能通过调用本类中的构造器完成初始化，不允许出现super.init
    convenience init(albumId: Int = 0) {
        self.init()
        
        self.albumId = albumId
    }
    
    public var  albumId: Int = 0
    // getff
    private lazy var heardViiew: FMPlayDetailView = {
        
        let heardView = FMPlayDetailView.init(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: 240))
        heardView.backgroundColor = UIColor.white
        
        return heardView
    }()
    private let oneVc = FMjianjieTableViewController()
    private let twoVc = FMjiemuTableViewController()
    private let threeVc = FMFindLikeTableViewController()
    private let fourVc = FMquanziTableViewController()
    lazy var viewcontroller: [UIViewController] = {
        
        return [oneVc,twoVc, threeVc,fourVc]
    }()
    
    private lazy var titles: [String] = {
       
         return ["简介", "节目", "找相似","圈子"]
        
    }()
     private lazy var rightBarButton1: UIButton = {
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "icon_more_h_30x31_"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick1), for: UIControlEvents.touchUpInside)
        return button
        
    }()
    
    private lazy var rightBarButton2: UIButton = {
        
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "icon_share_h_30x30_"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick2), for: UIControlEvents.touchUpInside)
        return button
        
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
    private var album: album?
    private var user: user?
    private var tracks: tracks?
    
    lazy var AdvancedManager: LTAdvancedManager = {
//       let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let statusBarH  = UIApplication.shared.statusBarFrame.size.height

        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: FMScreenHeigth ), viewControllers: self.viewcontroller, titles: self.titles, currentViewController: self, layout: self.layout, headerViewHandle: { [weak self] in
            
            guard let strongSelf = self else { return UIView() }
            
            let headerView = strongSelf.heardViiew
            
            return headerView
        })
        advancedManager.delegate = self
        /* 设置悬停位置 */
        advancedManager.hoverY = navigationBarHeight
        /* 点击切换滚动过程动画 */
//                advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navBarBackgroundAlpha = 0 
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navBarBackgroundAlpha = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        advancedManagerConfig()
        setupNav()
        self.navBarBackgroundAlpha = 0
    }
    func setupNav()  {
        let rightBarButtonItem1:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton1)
        let rightBarButtonItem2:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton2)
        
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem1, rightBarButtonItem2]
    }
    
    func  setUpUI()  {
        
        view.addSubview(self.AdvancedManager)
        
        loadData()
      
    }
    
    
    func loadData()  {
        
        FMPlayDetailProvider.request(FMPlayDetailAPI.playDetailData(albumId: self.albumId ,  20)) { result in
            
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let FMalbum = JSONDeserializer<album>.deserializeFrom(json: json["data"]["album"].description) {
                    
                    self.album = FMalbum
                }
                if let FMuser = JSONDeserializer<user>.deserializeFrom(json: json["data"]["user"].description) {
                    
                    self.user = FMuser
                }
                if let FMtrack = JSONDeserializer<tracks>.deserializeFrom(json: json["data"]["tracks"].description) { // 从字符串转换为对象实例
                    self.tracks = FMtrack
                     
                }
                // 给View复制
                self.heardViiew.albumModel = self.album
                self.oneVc.intorModel = self.album
                self.oneVc.UserModel = self.user
                self.twoVc.tracksModel = self.tracks
            }
        }
    }
    

}

extension FMPlaytDetailViewController {
    
    @objc func rightBarButtonClick1 ()  {
        
        
        print("1111")
    }
    @objc func rightBarButtonClick2 ()  {
        
        
        print("2222")
    }
}

extension FMPlaytDetailViewController : LTAdvancedScrollViewDelegate {
    private func advancedManagerConfig() {
        //MARK: 选中事件
        AdvancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        if (offsetY > 5)
        {
            let alpha = offsetY / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            self.rightBarButton1.setImage(UIImage(named: "icon_more_n_30x31_"), for: UIControlState.normal)
            self.rightBarButton2.setImage(UIImage(named: "icon_share_n_30x30_"), for: UIControlState.normal)
        }else{
            navBarBackgroundAlpha = 0
            self.rightBarButton1.setImage(UIImage(named: "icon_more_h_30x31_"), for: UIControlState.normal)
            self.rightBarButton2.setImage(UIImage(named: "icon_share_h_30x30_"), for: UIControlState.normal)
        }
    }
    
    
}
