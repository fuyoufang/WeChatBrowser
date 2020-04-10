//
//  IMConversation.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/9.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

/////////////////////////////////////////////////////////////////////
//
//                     腾讯云通信服务 IMSDK
//
//  模块名称：TIMConversation 会话模块
//
//  模块功能：一个会话对应一个聊天窗口，比如跟一个好友的 C2C 聊天叫做一个会话，一个聊天群也叫做一个会话。
//
//  TIMConversation 提供的接口函数都是围绕消息的相关操作，包括：消息发送、获取历史消息、设置消息已读、撤回和删除等等。
//
/////////////////////////////////////////////////////////////////////

import Foundation


class TIMConversation {

// MARK: 二，获取消息
/////////////////////////////////////////////////////////////////////////////////
//
//                      （二）获取消息
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 获取消息相关接口
/// @{
/**
 *  2.1 从云端拉取历史消息
 *
 *  如果用户的网络正常且登录成功，可以通过该接口拉取历史消息，该接口会返回云端存储的历史消息（最多存储7天）。
 *
 *  1. 单聊和群聊消息会在云端免费存储7天，如果希望存储更长时间，可前往
 *     ([IM 控制台](https://console.cloud.tencent.com/avc) -> 功能配置 -> 消息 ->消息漫游时长)进行购买，
 *     具体资费请参考 [价格说明](https://cloud.tencent.com/document/product/269/11673)。
 *
 *  2. 对于图片、语音等资源类消息，获取到的消息体只会包含描述信息，需要通过额外的接口下载数据，
 *     详情请参考 [消息收发]（https://cloud.tencent.com/document/product/269/9150）中的 "消息解析" 部分文档。
 *
 *  @param count 获取数量
 *  @param last  上次最后一条消息，如果 last 为 nil，从最新的消息开始读取
 *  @param succ  成功时回调
 *  @param fail  失败时回调
 *
 *  @return 0：本次操作成功；1：本次操作失败
 */
    func getMessage(count: Int, last: TIMMessage, succ: TIMGetMsgSucc, fail: TIMFail) -> Int {
        fatalError()
    }
/**
 *  2.2 从本地数据库中获取历史消息
 *
 *  如果客户网络异常或登录失败，可以通过该接口获取本地存储的历史消息，调用方法和 getMessage() 一致
 *  AVChatRoom,BChatRoom 消息数量很大，出于程序性能的考虑，默认不存本地，不能通过这个接口拉取到对应群消息
 *
 *  @param count 获取数量
 *  @param last  上次最后一条消息
 *  @param succ  成功时回调
 *  @param fail  失败时回调
 *
 *  @return 0：本次操作成功；1：本次操作失败
 */
    func getLocalMessage(count: Int, last: TIMMessage, succ: TIMGetMsgSucc, fail: TIMFail) -> Bool {
        fatalError()
    }

/**
 *  2.3 获取当前会话的最后一条消息
 *
 *  可用于“装饰”会话列表，目前大多数 App 的会话列表中都会显示该会话的最后一条消息
 *
 *  @return 最后一条消息
 */
    func getLastMsg() -> TIMMessage? {
        fatalError()
    }

// MARK: 五，获取会话信息
/////////////////////////////////////////////////////////////////////////////////
//
//                      （五）获取会话信息
//
/////////////////////////////////////////////////////////////////////////////////
/// @name 获取会话信息相关接口
/// @{

/**
 *  5.1 获取会话类型
 *
 *  @return 会话类型
 */
    func getType() -> TIMConversationType {
        fatalError()
    }

/**
 *  5.2 获取会话 ID
 *
 *  C2C：对方账号；Group：群组Id。
 *
 *  对同一个单聊或则群聊会话，getReceiver 获取的会话 ID 都是固定的，C2C 获取的是对方账号，Group 获取的是群组 Id。
 *
 *  @return 会话人
 */
    func getReceiver() -> String {
        fatalError()
    }

/**
 *  5.3 获取群名称
 *
 *  获取群名称，只有群会话有效。
 *
 *  @return 群名称
 */
    func getGroupName() -> String {
        fatalError()
    }

}

