//
//  ConversationCellView.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

let ConversationCellViewID = NSUserInterfaceItemIdentifier(rawValue: "ConversationCellView")

class ConversationCellView: NSTableCellView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = ConversationCellViewID
        layer?.backgroundColor = NSColor.orange.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
