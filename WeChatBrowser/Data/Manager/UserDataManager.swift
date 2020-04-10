//
//  UserDataManager.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/7.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
import WCDBSwift

let FriendTable = "Friend"
let SqliteMasterTable = "sqlite_master"

class UserDataManager {
    public var chatTableNames: [String]? {
        get {
            if _chatTableNames == nil {
                _chatTableNames = getChatTableNames()
            }
            return _chatTableNames
        }
    }
    
    public var friendsDB: [FriendDB]? {
        get {
            if _friendDBs == nil {
                _friendDBs = getFriendsFromDB()
            }
            return _friendDBs
        }
    }
    
    private var filePath: String // 数据路径
    private let contactDBFilePath: String
    private var _friendDBs: [FriendDB]?
    private var _chatTableNames: [String]?
    private let contactDatabase: Database
    private var chatMessageDatabase: Database
    
    init(filePath: String) {
        self.filePath = filePath
        self.contactDBFilePath = "\(filePath)/DB/WCDB_Contact.sqlite"
        self.contactDatabase = Database(withPath: self.contactDBFilePath)
        self.chatMessageDatabase = Database(withPath: "\(filePath)/DB/MM.sqlite")
    }
    
    func getFriendsFromDB() -> [FriendDB]? {
        
        do {
            let friendDBs: [FriendDB] = try self.contactDatabase.getObjects(fromTable: FriendTable)
            return friendDBs
        } catch let e {
            debugPrint(e)
        }
        return nil
    }
    
    func getChatTableNames() -> [String] {
        var chatTableNames = [String]()
        do {
            let sqliteMasters: [SqliteMaster] = try chatMessageDatabase.getObjects(fromTable: SqliteMasterTable, where: SqliteMaster.CodingKeys.type == "table")
            
            for sqliteMaster in sqliteMasters {
                guard let name = sqliteMaster.name else {
                    continue
                }
                guard name.hasPrefix("Chat_") else {
                    continue
                }
                chatTableNames.append(name)
            }
        } catch let e {
            debugPrint(e)
        }
        return chatTableNames
    }
    
    func getChatMessageDBs(userName: String) -> [MessageDB] {
        guard let chatTableNames = self.chatTableNames else {
            return []
        }
        
        let chatTableName = "Chat_\(userName.MD5())"
        let index = chatTableNames.firstIndex(where: { (item) -> Bool in
            return item == chatTableName
        })
        
        guard index != nil else {
            return []
        }
        
        return getChatMessageDBs(chatTableName: chatTableName)
    }
    
    func getChatMessageDBs(chatTableName: String) -> [MessageDB] {
        do {
            let chatMessages: [MessageDB] = try chatMessageDatabase.getObjects(fromTable: chatTableName)
            
            return chatMessages
        } catch let e {
            debugPrint(e)
        }
        return []
    }
}
