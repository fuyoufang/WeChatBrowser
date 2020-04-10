//
//  ConversationListView.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class ConversationListView: NSTableCellView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.orange.cgColor
        layer?.opacity = 1.0
        layer?.isOpaque = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
