//
//  TUISystemMessageCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/13.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

/**
 * 【模块名称】TUISystemMessageCellData
 * 【功能说明】系统消息单元数据源。
 *  存放系统消息所需要的信息与数据。
 *  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
 */
class TUISystemMessageCellData: TUIMessageCellData {

/**
 *  系统消息内容，例如“您撤回了一条消息。”
 */
    var content: String?

/**
 *  内容字体
 *  系统消息显示时的 UI 字体。
 */
    let contentFont: NSFont

/**
 *  内容颜色
 *  系统消息显示时的 UI 颜色。
 */
    let contentColor: NSColor?

    override init(direction: MsgDirection) {
        contentFont = NSFont.systemFont(ofSize: 13)
        contentColor = NSColor(red: 148.0 / 255.0,
                               green: 149.0 / 255.0,
                               blue: 149.0 / 255.0,
                               alpha: 1.0)
        super.init(direction: direction)
        cellLayout = TUIMessageCellLayout.systemMessageLayout
    }
    
    override func contentSize() -> CGSize {
        guard let content = self.content else {
            return super.contentSize()
        }
        
        var size = content.textSize(inSize: CGSize(width: TSystemMessageCell_Text_Width_Max, height: CGFloat(MAXFLOAT)), font: self.contentFont)
        size.height += 10
        size.width += 16
        return size
    }
    
    override func height(ofWidth width: CGFloat) -> CGFloat {
        return self.contentSize().height + 16
    }

}
