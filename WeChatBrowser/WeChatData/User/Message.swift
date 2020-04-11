//
//  Message.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/7.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
import WCDBSwift

//CREATE TABLE Chat_07bc6230daa2fbbae28aa0f68b3d225d(
//    CreateTime INTEGER DEFAULT 0,
//    Des INTEGER,
//    ImgStatus INTEGER DEFAULT 0,
//    MesLocalID INTEGER PRIMARY KEY AUTOINCREMENT,
//    Message TEXT,
//    MesSvrID INTEGER DEFAULT 0,
//    Status INTEGER DEFAULT 0,
//    TableVer INTEGER DEFAULT 1,
//    Type INTEGER)

// MARK: MessageDB

enum MessageDBType: Int {
    case text = 1
    case image = 3 // 图片
    case webURL = 49 // 链接。这里面包含的类别比较多，在 Message 里面会有 <title>、<des>、<url>、<thumburl> 等信息。微信应该是通过 <type> 标签来确定一些特殊的应用，比如 2001 是红包，2000 转账，17 实时位置共享，6 文件。
    case system = 10000 // 系统消息，就是那种居中的。
    case voice = 34 // 语音，消息里会有 <voicemsg> 标签，可以读出来长度等信息
    case emoji = 47 // 表情，<emoji> 标签里面可以找到一些信息。
    case video = 62 // 小视频，<videomsg>。
    case voipinvite = 50  // 视频/语音通话，<voipinvitemsg>。
    case position = 48  // 位置。
    case card = 42 // 名片。
}

class MessageDB: TableCodable {
    var CreateTime: UInt32? = 0
    var Des: Int? // 表示我是否为消息的接收方。
    var ImgStatus: Int? = 0
    var MesLocalID: Int?
    var Message: String? // Message 就是消息本身。
    var MesSvrID: Int? = 0
    var Status: Int? = 0
    var TableVer: Int? = 1
    var `Type`: Int? // Type 表示消息的类型，
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = MessageDB
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case CreateTime
        case Des
        case ImgStatus
        case MesLocalID
        case Message
        case MesSvrID
        case Status
        case TableVer
        case `Type`
    }
    
    public func getMessge() -> BaseMessage {
        switch self.Type {
        case MessageDBType.image.rawValue:
            let message = ImageMessage()
            setup(message: message)
            if let text = self.Message {
                message.image = MessageImageTool.messageImage(message: text)
            }
            return message
        case MessageDBType.webURL.rawValue:
            let message = WebURLMessage()
            setup(message: message)
            if let text = self.Message {
                message.url = MessageURLTool.messageURL(message: text)
            }
            return message
        default:
            let message = TextMessage()
            setup(message: message)
            return message
        }
    }
    
    func setup(message: BaseMessage) {
        message.createTime = self.CreateTime
        message.des = self.Des
        message.imgStatus = self.ImgStatus
        message.mesLocalID = self.MesLocalID
        if self.Type == MessageDBType.text.rawValue {
            message.message = self.Message
        }
        
        message.mesSvrID = self.MesSvrID
        message.status = self.Status
        message.tableVer = self.TableVer
        message.type = self.Type
        
    }
}

// MARK: Message
class BaseMessage {
    var createTime: UInt32? = 0
    var des: Int?
    var imgStatus: Int? = 0
    var mesLocalID: Int?
    var message: String?
    var mesSvrID: Int? = 0
    var status: Int? = 0
    var tableVer: Int? = 1
    var `type`: Int?
}

class TextMessage: BaseMessage {
    
}

class ImageMessage: BaseMessage {
    var image: MessageImage?
    
}

class WebURLMessage: BaseMessage {
    var url: MessageURL?
}


class MessageImage {
    var hdlength: String?
    var length: String?
    var hevc_mid_size: String?
    var cdnbigimgurl: String?
    var cdnmidimgurl: String?
    var aeskey: String?
    var cdnthumburl: String?
    var cdnthumblength: String?
    var cdnthumbwidth: String?
    var cdnthumbheight: String?
    var cdnthumbaeskey: String?
    var encryver: String?
    var md5: String?
    var filekey: String?
    var uploadcontinuecount: String?
}

struct WebviewShared  {
    var jsAppId: String?
}

class MessageURL {
    var title: String?
    var des: String?
    var type: String?
    var showtype: String?
    var soundtype: String?
    var contentattr: String?
    var url: String?
    var cdnthumburl: String?
    var cdnthumbmd5: String?
    var cdnthumblength: String?
    var cdnthumbwidth: String?
    var cdnthumbheight: String?
    var cdnthumbaeskey: String?
    var aeskey: String?
    var encryver: String?
    var filekey: String?
    var thumburl: String?
    var directshare: String?
    var webviewshared: WebviewShared?
}

