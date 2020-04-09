//
//  IMConversation+MsgExt.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
/////////////////////////////////////////////////////////////////////
//
//                     腾讯云通信服务 IMSDK
//
//  模块名称：TIMConversation + MsgExt
//
//  模块功能：此处主要存放待废弃的 API 函数，建议您使用 TIMConversation.h 内部声明的接口函数
//
/////////////////////////////////////////////////////////////////////

extension TIMConversation {

/**
 *  向前获取会话漫游消息
 *
 *  调用方式和 getMessage 一样，区别是 getMessage 获取的是时间更老的消息，主要用于下拉 Tableview 刷新消息数据，getMessageForward 获取的是时间更新的消息，主要用于上拉 Tableview 刷新消息数据。
 *
 *  @param count 获取数量
 *  @param last  上次最后一条消息，如果 last 为 nil，从最新的消息开始读取
 *  @param succ  成功时回调
 *  @param fail  失败时回调
 *
 *  @return 0：本次操作成功；1：本次操作失败
 */

    func getMessageForward(count: Int, last: IMMessage?, succ: TIMGetMsgSucc, fail: TIMFail) -> Bool {
        fatalError()
    }
/**
 *  获取指定会话消息
 *
 *  @param locators 消息定位符（IMMessageLocator）数组
 *  @param succ  成功时回调
 *  @param fail  失败时回调
 *
 *  @return 0：本次操作成功；1：本次操作失败
 */
    func findMessages(locators: [IMMessageLocator], succ: TIMGetMsgSucc, fail: TIMFail) -> Bool {
        fatalError()
    }

/**
 *  获取自己的 id
 *
 *  @return 用户 id
 */
    func getSelfIdentifier() -> String {
        fatalError()
    }
}
