//
//  TUISystemMessageCellLayout.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

/** 腾讯云TUIKit
 * 【模块名称】TUISystemTextCellLayout
 * 【功能说明】文本消息单元接收布局
 *  用于实现文本消息单元，在接收状态时的布局管理。
 *  本布局继承 TUIMessagCellLayout，当您想自定义布局时，可以从本布局进行修改并使用本布局，无需从父类直接修改。
 */
class TUISystemMessageCellLayout: TUIMessageCellLayout {

    override init() {
        super.init()
        self.messageInsets = NSEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}
