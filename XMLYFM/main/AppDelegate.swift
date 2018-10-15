//
//  AppDelegate.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: FMScreenHeigth))
        
        let  tab = self.customTabBar()
        
        self.window?.rootViewController = tab
        
        self.window?.makeKeyAndVisible()
        print("hahahahahah")
        
        return true
    }

    func customTabBar() -> ESTabBarController  {
        
         let tabBarController = ESTabBarController()
        tabBarController.title = "Irregularity"
        tabBarController.delegate = self as? UITabBarControllerDelegate
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
 
        
        //中间按钮的处理
        tabBarController.shouldHijackHandler = {
            
            tabBarController , viewController , index in

            if index == 2 {
                return true
            }
            
            return false
         }
       
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                                let vc = FMPlayViewController()
//                                tabBarController?.present(vc, animated: true, completion: nil)
            }
        }
        
         let vc1 = FMHomeViewController()
         let vc2 = FMListenViewController()
         let vc3 = FMPlayViewController()
         let vc4 = FMFindViewController()
         let vc5 = FMMineViewController()
        
        vc1.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        vc2.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我听", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        vc3.tabBarItem = ESTabBarItem.init(YYIrregularityContentView(), title: nil, image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"))
        vc4.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "发现", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        vc5.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        let n1 = YYNavigationController.init(rootViewController: vc1)
        let n2 = YYNavigationController.init(rootViewController: vc2)
        let n3 = YYNavigationController.init(rootViewController: vc3)
        let n4 = YYNavigationController.init(rootViewController: vc4)
        let n5 = YYNavigationController.init(rootViewController: vc5)
        vc1.title = "首页"
        vc2.title = "我听"
//        vc3.title = "播放"
        vc4.title = "发现"
        vc5.title = "我的"
        
        tabBarController.viewControllers = [n1, n2, n3, n4, n5]
        
        
         return tabBarController
    }
    

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

