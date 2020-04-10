//
//  UIMessageCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

/**
 *  消息状态枚举
 */
enum MsgStatus {
    case `init` //消息创建
    case sending //消息发送中
    case sending_2 //消息发送中_2，推荐使用
    case succ //消息发送成功
    case fail //消息发送失败
}

/**
 *  消息方向枚举
 *  消息方向影响气泡图标、气泡位置等 UI 风格。
 */

enum MsgDirection {
    case incoming //消息接收
    case outgoing //消息发送
}

/**
 * 【模块名称】TUIMessageCellData
 * 【功能说明】聊天消息单元数据源，配合消息控制器实现消息收发的业务逻辑。
 *  用于存储消息管理与逻辑实现所需要的各类数据与信息。包括消息状态、消息发送者 ID 与头像等一系列数据。
 *  同时信息数据单元整合并调用了 IM SDK，能够通过 SDK 提供的接口实现消息的业务逻辑。
 *  数据源帮助实现了 MVVM 架构，使数据与 UI 进一步解耦，同时使 UI 层更加细化、可定制化。
 */
class TUIMessageCellData: TCommonCellData {
    
    /**
     *  信息发送者 ID
     */
    var identifier: NSString?
    
    /**
     *  信息发送者头像 url
     */
    var avatarUrl: URL?
    
    /**
     *  信息发送者头像图像
     */
    var avatarImage: NSImage?
    
    /**
     *  信息发送者昵称
     *  昵称与 ID 不一定相同，在聊天界面默认展示昵称。
     */
    var name: String?
    
    /**
     *  名称展示 flag
     *  好友聊天时，默认不在消息中展示昵称。
     *  群组聊天时，对于群组内其他用户发送的信息，展示昵称。
     *  YES：展示昵称；NO：不展示昵称。
     */
    var showName: Bool = false
    
    /**
     *  消息方向
     *  消息方向影响气泡图标、气泡位置等 UI 风格。
     *  MsgDirectionIncoming 消息接收
     *  MsgDirectionOutgoing 消息发送
     */
    var direction: MsgDirection = .outgoing
    
    /**
     *  消息状态
     *  case Init 消息创建
     *  case Sending 消息发送中
     *  case Sending_2 消息发送中_2，推荐使用
     *  case Succ 消息发送成功
     *  case Fail 消息发送失败
     */
    var status: MsgStatus?
    
    /**
     *  内层消息
     *  IM SDK 提供的消息对象。内含各种获取消息信息的成员函数，包括获取优先级、获取元素索引、获取离线消息配置信息等。
     *  详细信息请参考 TXIMSDK_iOS\Frameworks\ImSDK.framework\Headers\IMMessage.h
     */
    var innerMessage: TIMMessage?
    
    /**
     *  昵称字体
     *  当需要显示昵称时，从该变量设置/获取昵称字体。
     */
    var nameFont: NSFont?
    
    /**
     *  昵称颜色
     *  当需要显示昵称时，从该变量设置/获取昵称颜色。
     */
    var nameColor: NSColor?
    
    /**
     *  发送时昵称颜色
     *  当需要显示昵称，且消息 direction 为 MsgDirectionOutgoing 时使用。
     */
    static var outgoingNameColor: NSColor?
    
    /**
     *  发送时昵称字体
     *  当需要显示昵称，且消息 direction 为 MsgDirectionOutgoing 时使用。
     */
    static var outgoingNameFont: NSFont?
    
    /**
     *  接收时昵称颜色
     *  当需要显示昵称，且消息 direction 为 MsgDirectionIncoming 时使用
     */
    static var incommingNameColor: NSColor?
    
    /**
     *  接收时昵称字体
     *  当需要显示昵称，且消息 direction 为 MsgDirectionIncoming 时使用
     */
    static var incommingNameFont: NSFont?
    
    /**
     *  消息单元布局
     *  包括消息边距、气泡内边距、头像边距、头像大小等 UI 布局。
     *  详细信息请参考 Section\Chat\CellLayout\TUIMessageCellLayout.h
     */
    var cellLayout: TUIMessageCellLayout?
    
    /**
     *  内容大小
     *  返回一个气泡内容的视图大小。
     */
    func contentSize() -> CGSize {
        fatalError()
    }
    
    
    /**
     *  根据消息方向（收/发）初始化消息单元
     *  除了基本消息的初始化外，还包括根据方向设置方向变量、昵称字体等。
     *  同时为子类提供可继承的行为。
     *
     *  @param direction 消息方向。MsgDirectionIncoming：消息接收；MsgDirectionOutgoing：消息发送。
     */
    
    init(direction: MsgDirection) {
        
    }
}
