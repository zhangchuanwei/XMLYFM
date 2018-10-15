//
//  FMjiemuTableViewController.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/12.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

class FMjiemuTableViewController: UITableViewController {

    
    
    private var Models: tracks?

    var tracksModel: tracks?  {
        
        didSet {
            guard let model = tracksModel else {return}
            self.Models = model
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        glt_scrollView = tableView
        tableView.register(PlayDetailProgramCell.self, forCellReuseIdentifier: "cell")
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.Models?.list?.count else {
            return 0
        }
        print("2222222333")
        return count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayDetailProgramCell

        cell.playDetailTracksList = self.Models?.list?[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    

}
