//
//  UserListTableCellView.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class UserListTableCellView: NSTableRowView {
 
    var user: IMUser? {
        didSet {
            nameLabel.stringValue = (user?.userName ?? user?.userNameMD5) ?? "未知"
        }
    }
    
    
    // MARK: UI

    let nameLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 14)
        $0.textColor = NSColor.white
    }
    
    // MARK: Initialize
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.left.equalTo(5)
            $0.right.equalTo(-5)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
}
