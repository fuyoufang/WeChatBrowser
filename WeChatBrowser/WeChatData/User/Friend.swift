//
//  Contact.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/7.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
import WCDBSwift
/*
 certificationFlag INTEGER DEFAULT 0,
 dbContactBrand BLOB,
 dbContactChatRoom BLOB,
 dbContactHeadImage BLOB,
 dbContactLocal BLOB,
 dbContactOpenIM BLOB,
 dbContactOther BLOB,
 dbContactProfile BLOB,
 dbContactRemark BLOB,
 dbContactSocial BLOB,
 encodeUserName TEXT,
 extFlag INTEGER DEFAULT 0,
 imgStatus INTEGER DEFAULT 0,
 openIMAppid TEXT,
 type INTEGER DEFAULT 0,
 userName TEXT PRIMARY KEY
 */

enum FriendDBType: Int {
    case t1 = 0 //微信运动
    case t2 = 1 //微信应用
    case t3 = 2 //    10    app + 群
    case t4 = 3 //   11    好友
    case t5 = 4 //   100    群里面的人
    case t6 = 6 //   110    群好友，对方加你，你未通过
    case t7 = 7 //   111    群里面的人，而且互为好友
    case t8 = 11//    1011    拉黑别人
    case t9 = 67//    1000011    标星
    case t10 = 256//    100000000    删除好友
    case t11 = 259//    100000011    不让他看我的朋友圈
    case t12 = 65539//    10000000000000011    不看他的朋友圈
}

struct HeadImage {
    var t: String? // 缩略图
    var r: String? // 原图
    var u: String?
    var s: String?
    
    var faceURL: String? {
        return ((r ?? t) ?? u) ?? s
    }
}

extension HeadImage: CustomDebugStringConvertible {
    var debugDescription: String {
        return "t:\(self.t ?? ""), r:\(self.r ?? ""), u:\(u ?? ""), s:\(s ?? "")"
    }
}


struct FriendDBChatRoom {
    
}

extension FriendDBChatRoom: CustomDebugStringConvertible {
    var debugDescription: String {
        return ""
    }
}

class FriendDB: TableCodable {
    
    var userName: String? // 微信号ID，如果以 @chatroom 结尾的，就是群
    var type: Int = 0
    var openIMAppid: String?
    var imgStatus: Int? = 0
    var extFlag: Int? = 0
    var encodeUserName: String?
    var certificationFlag: Int? = 0
    var dbContactBrand: Data?
    var dbContactChatRoom: Data? // 为群时有值，说明了群里的所有成员
    var dbContactHeadImage: Data?
    var dbContactLocal: Data?
    var dbContactOpenIM: Data?
    var dbContactOther: Data?
    var dbContactProfile: Data?
    var dbContactRemark: Data?
    var dbContactSocial: Data?
//
//    private var _chatRoom: FriendDBChatRoom?
//    var chatRoom: FriendDBChatRoom? {
//        get {
//            if _chatRoom == nil {
//                _chatRoom = getChatRoomData()
//            }
//            return _chatRoom
//        }
//    }
//
//    private func getChatRoomData() -> FriendDBChatRoom? {
//        guard let dbContactChatRoom = self.dbContactChatRoom else {
//            return nil
//        }
//        let chatRoomBytes = dbContactChatRoom.withUnsafeBytes {
//            [UInt8](UnsafeBufferPointer(start: $0, count: dbContactChatRoom.count))
//        }
//
//        #warning("TODO , 编码方式不对")
//        guard let result = String(data: dbContactChatRoom, encoding: .utf32) else {
//            return nil
//        }
//
//
//        return nil
//    }
//
//    var _isGroup: Bool? = nil
//    var isGroup: Bool {
//        get {
//            if _isGroup == nil {
//                _isGroup = (userName ?? "").hasSuffix("@chatroom")
//            }
//            return _isGroup!
//        }
//    }
//
//    private var _remarks: [String]?
//    var remarks: [String]? {
//        get {
//            if _remarks == nil {
//                _remarks = getRemarkData()
//            }
//            return _remarks
//        }
//    }
//
//    private var _headImage: HeadImage?
//    var headImage: HeadImage? {
//        get {
//            if _headImage == nil {
//                _headImage = getHeadImage()
//            }
//            return _headImage
//        }
//    }
//
//    private func getHeadImage() -> HeadImage? {
//        guard let dbContactHeadImage = self.dbContactHeadImage else {
//            return nil
//        }
//        let remarkBytes = dbContactHeadImage.withUnsafeBytes {
//            [UInt8](UnsafeBufferPointer(start: $0, count: dbContactHeadImage.count))
//        }
//
//        guard let result = String(data: dbContactHeadImage, encoding: .utf8) else {
//            return nil
//        }
//
//
//        let start = "\u{12}" // 开始
//        let end = "\u{0}" // 结束
//        let separator = String("\u{08}\u{03}\u{1A}")
//
//        guard let startRange = result.range(of: start) else {
//            return nil
//        }
//        guard let endRange = result.range(of: end) else {
//            return nil
//        }
//        let info = result[startRange.upperBound..<endRange.lowerBound]
//
//        if let separatorRange = info.range(of: separator) {
//            let url1 = String(result[info.startIndex..<separatorRange.lowerBound])
//            let url2 = String(result[separatorRange.upperBound..<info.endIndex])
//            return getHeadImage(texts: [url1, url2])
//        } else {
//            return getHeadImage(texts: [String(info)])
//        }
//
//    }
//
//    private func getHeadImage(texts: [String]) -> HeadImage {
//        var headImage = HeadImage()
//        for text in texts {
//            guard text.count > 2 else {
//                continue
//            }
//
//            let first = text[..<text.index(text.startIndex, offsetBy: 1)]
//            let start = text.index(text.startIndex, offsetBy: 1)
//            let imageURL = String(text[start...])
//
//            switch first {
//            case "T":
//                headImage.t = imageURL
//            case "R":
//                headImage.r = imageURL
//            case "S":
//                headImage.s = imageURL
//            case "U":
//                headImage.u = imageURL
//            default:
//                headImage.s = imageURL
//            }
//            if text.hasPrefix("h") {
//
//            }
//        }
//        return headImage
//    }
//
//    // 解析 dbContactRemark
//    private func getRemarkData() -> [String]? {
//        guard let dbContactRemark = self.dbContactRemark else {
//            return nil
//        }
//
//        let remarkBytes = dbContactRemark.withUnsafeBytes {
//            [UInt8](UnsafeBufferPointer(start: $0, count: dbContactRemark.count))
//        }
//        var remarks = [String]()
//        var len: UInt8 = 0
//        var index: UInt8 = 0
//        while true {
//            index += 1
//            if index > remarkBytes.count {
//                break
//            }
//            len = remarkBytes[Int(index)]
//            index += 1
//            if index + len > remarkBytes.count {
//                break
//            }
//
//            let remark = String(data: dbContactRemark[Int(index)..<Int(index + len)], encoding: .utf8)
//            guard remark != nil else {
//                continue
//            }
//            remarks.append(remark!)
//
//            index += len
//        }
//        return remarks
//    }
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = FriendDB
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case userName
        case type
        case openIMAppid
        case imgStatus
        case extFlag
        case encodeUserName
        case certificationFlag
        case dbContactBrand
        case dbContactChatRoom
        case dbContactHeadImage
        case dbContactLocal
        case dbContactOpenIM
        case dbContactOther
        case dbContactProfile
        case dbContactRemark
        case dbContactSocial
    }
}

extension FriendDB: CustomDebugStringConvertible {
    var debugDescription: String {
        return """
        userName:\(userName ?? "")
        """
    }
}

class Friend {
    var userName: String?
    var type: Int = 0
    var openIMAppid: String?
    var imgStatus: Int = 0
}
