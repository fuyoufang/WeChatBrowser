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
    
    public func getFirstUserData() -> UserDataManager? {
        guard let userDataFileName = userDataFileNames.first else {
            return nil
        }
        currentUserDataManager = UserDataManager(filePath: "\(documentsPath)/\(userDataFileName)")
        
        return currentUserDataManager
    }
    
}
