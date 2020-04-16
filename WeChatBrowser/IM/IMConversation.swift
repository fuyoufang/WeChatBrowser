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
import WCDBSwift

class TIMConversation {
    private let database: Database
    private let tableName: String
    let friendshipManager: TIMFriendshipManager
    let filePath: String // 图片保存地址
    let friend: TIMFriend
    private(set) lazy var imageFilePath: String = {
        return "\(filePath)/Img/\(self.friend.identifier?.MD5() ?? "")"
    }()
    // MARK: 初始化
    init(database: Database,
         tableName: String,
         filePath: String,
         friend: TIMFriend,
         friendshipManager: TIMFriendshipManager) {
        self.database = database
        self.tableName = tableName
        self.friend = friend
        self.friendshipManager = friendshipManager
        self.filePath = filePath
    }
    
    // MARK: 二，获取消息
    /////////////////////////////////////////////////////////////////////////////////
    //
    //                      （二）获取消息
    //
    /////////////////////////////////////////////////////////////////////////////////
    /// @name 获取消息相关接口
    /// @{
    
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
    
    func getChatMessageDBs(count: Int, last: TIMMessage?) -> [TIMMessage]? {
        do {
            if last != nil {
                // fatalError()
            }
            let orderBy = [MessageDB.CodingKeys.MesLocalID.asOrder(by: .descending)]
            let messsages: [TIMMessage] =
                try database
                    .getObjects(fromTable: tableName,
                                orderBy: orderBy,
                                limit: count).map { TIMMessage(messageDB: $0, conversation: self)
            }
            
            return messsages
        } catch let e {
            debugPrint(e)
        }
        return nil
    }
    
    func getLocalMessage(count: Int, last: TIMMessage?, succ: TIMGetMsgSucc, fail:TIMFail) -> Bool {
        let messages = getChatMessageDBs(count: count, last: last) ?? []
        succ(messages)
        return true
    }
    
    /**
     *  2.3 获取当前会话的最后一条消息
     *
     *  可用于“装饰”会话列表，目前大多数 App 的会话列表中都会显示该会话的最后一条消息
     *
     *  @return 最后一条消息
     */
    private var lastMsg: TIMMessage?
    
    func getLastMsg() -> TIMMessage? {
        if lastMsg == nil {
            lastMsg = getChatMessageDBs(count: 1, last: nil)?.first
        }
        return lastMsg
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
        friend.isGroup ? .GROUP : .C2C
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
    
    var receiver: String {
        get {
            friend.identifier ?? ""
        }
    }
    
    /**
     *  5.3 获取群名称
     *
     *  获取群名称，只有群会话有效。
     *
     *  @return 群名称
     */
    func getGroupName() -> String? {
        guard friend.isGroup else {
            return nil
        }
        return friend.remarks?.first ?? "群名"
    }
}

