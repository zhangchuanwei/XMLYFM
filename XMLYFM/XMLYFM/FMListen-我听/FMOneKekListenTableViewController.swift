//
//  FMOneKekListenTableViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/16.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class FMOneKekListenTableViewController: UITableViewController {
    var channelResults:[ChannelResultsModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.tableFooterView = self.footview
        tableView.register(FMOneKeylistenCell.self, forCellReuseIdentifier: "reuseIdentifier")
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        loadData()
    }

    lazy var footview: UIView = {
      
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: FMScreenWidth, height: 100))
        
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 20
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor.lightGray
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitle("➕添加订阅", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(addButtonClick), for:UIControlEvents.touchUpInside )
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        return view
    }()
    @objc func addButtonClick(){
        let VC = FMMoreChannelVC()
        VC.title = "更多"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func loadData()  {
        FMListenProvider.request(FMListenAPI.listenChannelList) { (result) in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<ChannelResultsModel>.deserializeModelArrayFrom(json: json["data"]["channelResults"].description) { // 从字符串转换为对象实例
                    self.channelResults = mappedObject as? [ChannelResultsModel]
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.channelResults?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FMOneKeylistenCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FMOneKeylistenCell



        cell.channelResults = self.channelResults?[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
