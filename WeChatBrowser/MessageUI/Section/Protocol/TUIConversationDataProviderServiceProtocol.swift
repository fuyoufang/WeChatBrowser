//
//  TUIConversationDataProviderServiceProtocol.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/13.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

protocol TUIConversationDataProviderServiceProtocol {

/**
 *  获取消息数据。
 *  该协议可以帮助您实现：
 *  1、当前网络状态为连接失败/未连接时，调用 IM SDK 中 TIMConversation 类的 getLocalMessage 接口从本地拉取消息。
 *  2、当当前网络状态正常时，调用 IM SDK 中 TIMConversation 类的 getMessage 接口在线拉取消息。
 *
 *  @param conv 会话示例，负责提供消息的拉取功能。
 *  @param count 想要拉取的消息数目。
 *  @param last 上次最后一条消息
 *  @param succ 成功回调。
 *  @param fail 失败回调。
 *
 *  @return 0:本次操作成功；1:本次操作失败。
 */
    func getMessage(conv: TIMConversation, count: Int, last: TIMMessage?, succ: TIMGetMsgSucc, fail: TIMFail) -> Bool
}
