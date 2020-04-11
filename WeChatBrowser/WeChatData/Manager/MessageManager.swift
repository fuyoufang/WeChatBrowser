//
//  MessageManager.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/7.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class MessageManager {
    
    let appPath: String
    let documentsPath: String
    var userDataFileNames = [String]()
    var currentUserDataManager: UserDataManager?
    
    public init(appPath: String) {
        self.appPath = appPath
        self.documentsPath = "\(appPath)/Documents"
        setup()
    }
    
    func setup() {
        userDataFileNames = getUserDataPaths()
    }
    
    public func getUserDataPaths() -> [String] {
        var userDataFileNames = [String]()
        do {
            let array = try FileManager.default.contentsOfDirectory(atPath: documentsPath)
            
            for fileName in array {
                let fullPath = "\(documentsPath)/\(fileName)/DB/MM.sqlite"
                
                if FileManager.default.fileExists(atPath: fullPath) {
                    userDataFileNames.append(fileName)
                }
            }
        } catch let e {
            debugPrint(e)
            
        }
        return userDataFileNames
    }
    
    public func getData(userNameMD5: String) -> UserDataManager? {
        guard userDataFileNames.contains(userNameMD5) else {
            return nil
        }
        return UserDataManager(filePath: "\(documentsPath)/\(userNameMD5)")
    }
    
    public func getData(user: IMUser) -> UserDataManager? {
        guard let userNameMD5 = user.userNameMD5 else {
            return nil
        }
        return getData(userNameMD5: userNameMD5)
    }
    
}
