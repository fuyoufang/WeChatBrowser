//
//  TUIConversationCellData.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
/******************************************************************************
 *
 *  本文件声明了用于实现会话单元数据源的模块。
 *  会话单元数据源（以下简称“数据源”）包含了会话单元显示所需的一系列信息与数据，这些信息与数据将会在下文进一步说明。
 *  数据源中还包含了部分的业务逻辑，如获取并生成消息概览（subTitle），更新会话信息（群消息或用户消息更新）等逻辑。
 *
 ******************************************************************************/

/**
 * 【模块名称】会话单元数据源（TUIConversationCellData）
 *
 * 【功能说明】存放会话单元所需的一系列信息和数据。
 *  会话单元数据源包含以下信息与数据：
 *  1、会话 ID。
 *  2、会话类型。
 *  3、头像 URL 与头像图片。
 *  4、会话标题与信息概览（副标题）。
 *  5、会话时间（最新一条消息的收/发时间）。
 *  6、会话未读计数。
 *  7、会话置顶标识。
 *  数据源中还包含了部分的业务逻辑，如获取并生成消息概览（subTitle），更新会话信息（群消息或用户消息更新）等逻辑。
 */
class TUIConversationCellData: TCommonCellData {
    
    
    /**
     *  会话 ID，用于唯一标识一个会话。
     *  我们通过此 ID 从服务器拉取会话相关的资料，包括 TIMConversation 对象与群组/用户资料。
     */
    var convId: String?
    
    /**
     *  会话类型。
     *TIM_C2C 类型
     *TIM_GROUP 群聊 类型
     *TIM_SYSTEM 系统消息
     */
    var convType: TIMConversationType = .C2C
    
    /**
     *  头像 URL
     */
    var avatarUrl: URL?
    
    /**
     *  头像图片，通过头像 URL 获取。
     */
    var avatarImage: NSImage?
    
    /**
     *  会话标题
     *  当该会话为1对1好友会话时，标题为好友的备注，若对应好友没有备注的话，则显示好友 ID。
     *  当该会话为群聊时，标题为群名称。
     */
    var title: String?
    
    /**
     *  会话消息概览（下标题）
     *  概览负责显示对应会话最新一条消息的内容/类型。
     *  当最新的消息为文本消息/系统消息时，概览的内容为消息的文本内容。
     *  当最新的消息为多媒体消息时，概览的内容为对应的多媒体形式，如：“动画表情” / “[文件]” / “[语音]” / “[图片]” / “[视频]” 等。
     *  若当前会话有草稿时，概览内容为：“[草稿]XXXXX”，XXXXX为草稿内容。
     */
    var subTitle: String?
    
    /**
     *  最新消息时间
     *  记录会话中最新消息的接收/发送时间。
     */
    var time: Date?
    
    /**
     *  当前会话的未读计数。用于在消息列表界面进行未读提醒。
     */
    var unRead: Int = 0
    
    /**
     *  会话置顶位
     *  YES：会话置顶；NO：会话未置顶。
     */
    var isOnTop: Bool = false
    
    
    override func height(ofWidth width: CGFloat) -> CGFloat {
        return TConversationCell_Height
    }
    
    
    //
    //- (BOOL)isEqual:(TUIConversationCellData *)object
    //{
    //    return [self.convId isEqual:object.convId];
    //}
}


