//
//  TUIConversationDataProviderService.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/13.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class TUIConversationDataProviderService : TUIConversationDataProviderServiceProtocol {

    static func singleton() -> Bool{
        return true
    }
    
    func getMessage(conv: TIMConversation, count: Int, last: TIMMessage?, succ: TIMGetMsgSucc, fail: TIMFail) -> Bool {
        return conv.getLocalMessage(count: count, last: last, succ: succ, fail: fail)
    }

}
