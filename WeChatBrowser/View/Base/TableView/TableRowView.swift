//
//  TableRowView.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class TableRowView: NSTableRowView {

    override var isGroupRowStyle: Bool {
        didSet {
            setNeedsDisplay(bounds)
        }
    }

    override func drawSelection(in dirtyRect: NSRect) {
        if window?.isKeyWindow == false || NSApp.isActive == false {
            super.drawSelection(in: dirtyRect)
        } else {
            NSColor.selection.set()
            dirtyRect.fill()
        }
    }

    override func drawBackground(in dirtyRect: NSRect) {
        if isGroupRowStyle {
            NSColor.sectionHeaderBackground.set()
            dirtyRect.fill()
        } else {
            super.drawBackground(in: dirtyRect)
        }
    }

}
