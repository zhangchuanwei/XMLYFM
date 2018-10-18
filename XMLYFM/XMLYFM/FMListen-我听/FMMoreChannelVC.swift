//
//  FMMoreChannelVC.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/17.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
class FMMoreChannelVC: UIViewController {

    private var channelClassInfo:[ChannelClassInfoModel]?   // 左边的数据
    private var channelInfo:[ChannelInfosModel]?       // 右边的数据
    // 标志最后一次选中的左边的cell
    private var lastPath:IndexPath?
    let FMLetfTableCellId = "FMLetfTableCellId"
    let FMOneKeylistenCellId = "FMOneKeylistenCellId"
    private lazy var letftTabView: UITableView = {
       
        let tabview = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0.2 * FMScreenWidth, height: FMScreenHeigth ), style: .plain)
        tabview.delegate = self
        tabview.dataSource = self
        tabview.showsVerticalScrollIndicator = false
        tabview.showsHorizontalScrollIndicator = false
        tabview.register(FMLetfTableCell.self, forCellReuseIdentifier: FMLetfTableCellId)
        return tabview
        
    }()
    
  
    private lazy var rightTabView: UITableView = {
        
        let tabview = UITableView.init(frame: CGRect(x: 0.2 * FMScreenWidth, y: 0, width: 0.8 * FMScreenWidth, height: FMScreenHeigth), style: UITableViewStyle.grouped)
        tabview.delegate = self
        tabview.dataSource = self
        tabview.showsVerticalScrollIndicator = false
        tabview.showsHorizontalScrollIndicator = false
        tabview.register(FMOneKeylistenCell.self, forCellReuseIdentifier: FMOneKeylistenCellId)
        tabview.separatorStyle = .none
        return tabview
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        view.addSubview(self.letftTabView)
        view.addSubview(self.rightTabView)
        self.loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "listenMoreChannel", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<ChannelClassInfoModel>.deserializeModelArrayFrom(json: json["classInfos"].description) {
            self.channelClassInfo = mappedObject as? [ChannelClassInfoModel]
        }
    }
    

}

extension FMMoreChannelVC : UITableViewDataSource , UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.letftTabView {
            return 1
        }
        
        return self.channelClassInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.letftTabView {
          return  self.channelClassInfo?.count ?? 0
        }
         return self.channelClassInfo?[section].channelInfos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.letftTabView {
            return 80
        }
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.letftTabView {
            return 0
        }
        return 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = UIView()
        footView.backgroundColor = UIColor.white
        return footView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x:20, y:0, width:80, height:40)
        let titleName:String = (self.channelClassInfo?[section].className)!
        let count:Int = (self.channelClassInfo?[section].channelInfos?.count)!
        titleLabel.text = "\(titleName)(\(count))"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.lightGray
        headerView.addSubview(titleLabel)
        let lineView = UIView()
        lineView.frame = CGRect(x:80, y:20,width:FMScreenWidth*0.8-100, height:0.5)
        lineView.backgroundColor = UIColor.lightGray
        headerView.addSubview(lineView)
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.letftTabView {
            
            let cell: FMLetfTableCell = tableView.dequeueReusableCell(withIdentifier: FMLetfTableCellId, for: indexPath) as! FMLetfTableCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.channelClassInfo = self.channelClassInfo?[indexPath.row]
            
            if indexPath.row == 0 {
                
                self.lastPath = indexPath
            }
            
            if self.lastPath == indexPath {
                cell.line.isHidden = false
                cell.title.textColor = UIColor.red
            }else{
                cell.line.isHidden = true
                cell.title.textColor = UIColor.black
            }
            
            
            return cell

        }
        
        let cell: FMOneKeylistenCell = tableView.dequeueReusableCell(withIdentifier: FMOneKeylistenCellId, for: indexPath) as! FMOneKeylistenCell

        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.channelInfoModel = self.channelClassInfo?[indexPath.section].channelInfos?[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if  tableView == self.letftTabView {
            
            let lastCell: FMLetfTableCell  = tableView.cellForRow(at: self.lastPath!) as! FMLetfTableCell
            lastCell.title.textColor = UIColor.black
            lastCell.line.isHidden = true
            
            let cell: FMLetfTableCell  = tableView.cellForRow(at: indexPath ) as! FMLetfTableCell
            cell.title.textColor = UIColor.red
            cell.line.isHidden = false
            
            self.lastPath = indexPath
            
            
            let rightIndex = IndexPath.init(row: 0, section: indexPath.row)
            
            self.rightTabView.scrollToRow(at: rightIndex, at: .top, animated: true)
            
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
        if scrollView == self.rightTabView {
            // 取出当前视图区域在最上面的cell得indexpath
            let topHeaderViewIndexPath = self.rightTabView.indexPathsForVisibleRows?.first
            print(topHeaderViewIndexPath!)
            guard  let rightSection = topHeaderViewIndexPath?.section else {
                
                return
            }
            let letftRow =  rightSection
            let leftIndexpath = IndexPath.init(row: letftRow, section: 0)
            if (self.lastPath != nil) {
                let lastCell: FMLetfTableCell  = self.letftTabView.cellForRow(at: self.lastPath!) as! FMLetfTableCell
                lastCell.title.textColor = UIColor.black
                lastCell.line.isHidden = true
                
                let cell: FMLetfTableCell  = self.letftTabView.cellForRow(at: leftIndexpath ) as! FMLetfTableCell
                cell.title.textColor = UIColor.red
                cell.line.isHidden = false
                
                self.lastPath = leftIndexpath
            }
            self.letftTabView.selectRow(at: leftIndexpath, animated: true, scrollPosition: .top)
            
        }
    }
    
   
    
}

