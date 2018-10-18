//
//  FMLetfTableCell.swift
//  XMLYFM
//
//  Created by 张传伟 on 2018/10/17.
//  Copyright © 2018年 张传伟. All rights reserved.
//

import UIKit

class FMLetfTableCell: UITableViewCell {

    lazy var line: UIView = {
      
        let line = UIView()
        line.backgroundColor = UIColor.red
        return line
        
    }()
    lazy var title: UILabel = {
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16)
        
        return title
        
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    func setUpUI()  {
        
        self.addSubview(self.line)
        
        self.line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(4)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.title)
        self.title.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.left.equalTo(self.line.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
    var channelClassInfo: ChannelClassInfoModel? {
        didSet {
            guard let model = channelClassInfo else {return}
            self.title.text = model.className
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
