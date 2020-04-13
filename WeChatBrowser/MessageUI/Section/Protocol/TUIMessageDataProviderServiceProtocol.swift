//
//  TUIMessageDataProviderServiceProtocol.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

protocol TUIMessageDataProviderServiceProtocol {

/**
 *  获取待显示的字符串。
 *  根据传入的消息状态，返回一个与状态对应的字符串。
 *  返回的字符串包括以下几种：
 *  1、消息撤回 —— “您撤回了一条消息” / “XXX 撤回了一条消息”。
 *  2、多媒体消息 —— “[图片]” / “[视频]” / “[语音]” / “[文件]” / “[动画表情]”。
 *  3、群消息修改 —— “XXX 修改群名为 XXX” / “XXX 修改群简介为 XXX” / “XXX 修改群公告为 XXX” / “XXX 修改群主为 XXX”。
 *  4、群成员变动 —— “XXX 将 XXX 踢出群组” / “XXX 加入群组” / “XXX 邀请 XXX 加入群组” / “XXX 推出了群聊”
 *  本函数回根据传入的 message 状态返回响应的字符串信息。您可以使用得到的字符串，进行系统消息的显示，或是在消息列表的对应会话中展示消息概览。
 *
 *  @param message 传入的消息，类型为 TIMMessage。
 *
 *  @return 根据 message 信息返回的对应字符串。
 */
//    func getDisplayString(message: TIMMessage) -> String?
    func getDisplayString(friendshipManager: TIMFriendshipManager, message: TIMMessage) -> String?
    func getCellData(message: TIMMessage, fromElem elem: TIMElem) -> TUIMessageCellData?

    func getTextCellData(message: TIMMessage, fromElem elem: TIMElem) -> TUITextMessageCellData?
    
//    func getFaceCellData(message: TIMMessage, fromElem elem: TIMElem) -> TUIFaceMessageCellData?
//
//    func getImageCellData(message: TIMMessage, fromElem elem: TIMElem) -> TUIImageMessageCellData?

//- (TUIVoiceMessageCellData *) getVoiceCellData:(TIMMessage *)message fromElem:(TIMSoundElem *)elem;
//
//- (TUIVideoMessageCellData *) getVideoCellData:(TIMMessage *)message fromElem:(TIMVideoElem *)elem;
//
//- (TUIFileMessageCellData *) getFileCellData:(TIMMessage *)message fromElem:(TIMFileElem *)elem;
//
//- (TUISystemMessageCellData *) getSystemCellData:(TIMMessage *)message formElem:(TIMElem *)elem;
//
//- (TUISystemMessageCellData *) getRevokeCellData:(TIMMessage *)message;
}
