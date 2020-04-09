//
//  CommonCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class CommonCell: NSTableCellView {
    var data: CommonCellData?
    
    // MARK: initialize
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        layer?.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    func fill(withData data: CommonCellData) {
        self.data = data
    }
}
