//
//  FMjiemuTableViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/12.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import MJRefresh
import HandyJSON
import SwiftyJSON
class FMjiemuTableViewController: UITableViewController {

    private var Models: tracks?

    var albumID: Int = 0
    
    var AalbumID: Int? {
     
        didSet{
            guard let a = AalbumID else {
                return
            }
            
          self.albumID = a
        }
        
    }
    var dataArr: [list]?
    
    
    var tracksModel: tracks?  {
        
        didSet {
            guard let model = tracksModel else {return}
            self.Models = model
            
            self.dataArr = model.list
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glt_scrollView = tableView
        tableView.register(PlayDetailProgramCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
           
            self.addData()
        })
        
    }
    
    func addData()  {
        
        guard let albumID  = self.AalbumID else {
            self.tableView.mj_footer.endRefreshing()
            return
        }
        FMPlayDetailProvider.request(.playDetailData(albumId: albumID, 20)) { Result in
            
            if case let .success(response) = Result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let FMtrack = JSONDeserializer<tracks>.deserializeFrom(json: json["data"]["tracks"].description) { // 从字符串转换为对象实例
                    guard  let list = FMtrack.list else {
                        return
                    }
                    
                   self.dataArr?.append(contentsOf: list)
                    self.tableView.mj_footer.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.dataArr?.count else {
            return 0
        }
        
        return count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayDetailProgramCell

        cell.playDetailTracksList = self.dataArr?[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    

}
