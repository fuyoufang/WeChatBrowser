//
//  CommonCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class CommonCell: NSTableCellView {
    var data: TCommonCellData?
    
    // MARK: initialize
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor(red: 243.0 / 255.0,
                                         green: 243.0 / 255.0,
                                         blue: 243.0 / 255.0,
                                         alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    func fill(withData data: TCommonCellData) {
        self.data = data
    }
}
