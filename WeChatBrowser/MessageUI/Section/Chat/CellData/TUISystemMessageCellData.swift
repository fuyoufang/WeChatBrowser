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
    var contentFont: NSFont?

/**
 *  内容颜色
 *  系统消息显示时的 UI 颜色。
 */
    var contentColor: NSColor?

}
