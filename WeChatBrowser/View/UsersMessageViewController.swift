//
//  UsersMessageViewController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class UsersMessageViewController: NSSplitViewController {
    
    let userListViewController = UserListViewController()
    let userMessageViewController = UserMessageViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    func setupSubviews() {
        splitView.isVertical = true // 中间分隔区的方向,水平或垂直
        splitView.dividerStyle = .thin
        // v.dividerThickness = 100 // 隔区的大小、宽度或高度(根据vertical类型)。
        splitView.addSubview(userListViewController.view)
        
//        splitViewItems = [
//            NSSplitViewItem(viewController: NSTabViewController()),
//            NSSplitViewItem(viewController: NSTabViewController()),
//        ]
    }
    
}
