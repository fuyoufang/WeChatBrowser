//
//  Label.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class Label: NSTextField {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.isEnabled = false
        //self.translatesAutoresizingMaskIntoConstraints = false
        //l.textColor = .primaryText
        self.cell?.backgroundStyle = .dark
//        self.lineBreakMode = .byTruncatingTail
        self.lineBreakMode = .byCharWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
