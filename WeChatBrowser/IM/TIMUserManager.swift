//
//  TIMUserManager.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/11.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class TIMUserManager {
    let user: IMUser
    let friendshipManager: TIMFriendshipManager
    let groupManager: TIMGroupManager
    let userData: UserDataManager
    
    init(userData: UserDataManager, user: IMUser) {
        self.user = user
        self.friendshipManager = TIMFriendshipManager(contactDatabase: userData.contactDatabase)
        self.groupManager = TIMGroupManager()
        self.userData = userData
    }
    
    // MARK: 三，会话管理器
    /////////////////////////////////////////////////////////////////////////////////
    //
    //                      （三）会话管理器
    //
    /////////////////////////////////////////////////////////////////////////////////
    /// @name 会话管理器
    /// @{
    
    /**
     *  3.1 获取会话列表
     *
     *  一个会话对应一个聊天窗口，比如跟一个好友的 1v1 聊天，或者一个聊天群，都是一个会话。
     *
     *  @return 会话列表
     */
    private var _conversationList: [TIMConversation]?
    var conversationList: [TIMConversation] {
        get {
            if _conversationList == nil {
                _conversationList = getConversationList()
            }
            return _conversationList!
        }
    }
    
    private func getConversationList() -> [TIMConversation] {

        guard let chatTableNames = userData.chatTableNames else {
            return []
        }
        let friends = friendshipManager.friends
        var conversations = [TIMConversation]()
        for tableName in chatTableNames {
            let md5 = tableName.replacingOccurrences(of: ChatTableNamePrefix, with: "")
            for friend in friends {
                if md5 == friend.identifier?.MD5() {
                    conversations.append(TIMConversation(database: userData.chatMessageDatabase, tableName: tableName, filePath: userData.filePath, friend: friend, friendshipManager: friendshipManager))
                    break
                }
            }
        }
        return conversations
    }
    
    /**
     *  3.2 获取单个会话
     *
     *  TIMConversation 负责会话相关操作，包含发送消息、获取会话消息缓存、获取未读计数等。
     *
     *  @param type 详情请参考 TIMComm.h 里面的 TIMConversationType 定义
     *  @param conversationId 会话 ID
     单聊类型（C2C）   ：为对方 userID；
     群组类型（GROUP） ：为群组 groupId；
     系统类型（SYSTEM）：为 @""
     *
     *  @return 会话对象，详情请参考 TIMConversation.h 里面的 TIMConversation 定义
     */
    func getConversation(type: TIMConversationType, conversationId: String) -> TIMConversation? {
        return conversationList.first { (conversation) -> Bool in
            return conversation.getType() == type && conversation.receiver == conversationId
        }
    }
}
