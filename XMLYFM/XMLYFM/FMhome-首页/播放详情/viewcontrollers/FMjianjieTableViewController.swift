//
//  FMjianjieTableViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/12.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import LTScrollView

class FMjianjieTableViewController: UITableViewController , LTTableViewProtocal{


    
    var intorModel: album? {
        didSet {
            
        }
    }
    
    var UserModel : user? {
        didSet {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navBarBackgroundAlpha = 0
        tableView.frame = CGRect(x: 0, y: 0, width: FMScreenWidth, height: FMScreenHeigth)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
       
    }

    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        if cell == nil {
            
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text  = "dddd" + String(indexPath.row)
    
        return cell!
    }

}



