//
//  MessageTool.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation


class MessageImageTool: NSObject {
    
    var messageImage: MessageImage?
    private let message: String
    //当前元素名
    private var currentElement: String?
    
    init(message: String) {
        self.message = message
    }
    
    class func messageImage(message: String) -> MessageImage? {
        return MessageImageTool(message: message).getImage()
    }
    
    func getImage() -> MessageImage? {
        guard let imageData = message.data(using: .utf8) else {
            return nil
        }
        
        let parser = XMLParser(data: imageData)
        parser.delegate = self
        parser.parse()
        return messageImage
    }
    
    
}

extension MessageImageTool: XMLParserDelegate {
    // 遇到一个开始标签时调用
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "img" {
            let messageImage = MessageImage()
            messageImage.hdlength = attributeDict["hdlength"]
            messageImage.length = attributeDict["length"]
            messageImage.hevc_mid_size = attributeDict["hevc_mid_size"]
            messageImage.cdnbigimgurl = attributeDict["cdnbigimgurl"]
            messageImage.cdnmidimgurl = attributeDict["cdnmidimgurl"]
            messageImage.aeskey = attributeDict["aeskey"]
            messageImage.cdnthumburl = attributeDict["cdnthumburl"]
            messageImage.cdnthumblength = attributeDict["cdnthumblength"]
            messageImage.cdnthumbwidth = attributeDict["cdnthumbwidth"]
            messageImage.cdnthumbheight = attributeDict["cdnthumbheight"]
            messageImage.cdnthumbaeskey = attributeDict["cdnthumbaeskey"]
            messageImage.encryver = attributeDict["encryver"]
            messageImage.md5 = attributeDict["md5"]
            messageImage.filekey = attributeDict["filekey"]
            messageImage.uploadcontinuecount = attributeDict["uploadcontinuecount"]
            
            self.messageImage = messageImage
        }
    }
    
    // 遇到字符串时调用
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        //接下来每遇到一个字符，将该字符追加到相应的 property 中
        //        switch currentElement{
        //        case "name":
        //            user.name = user.name ?? "" + data
        //        case "mobile":
        //            user.mobile = user.mobile ?? "" +  data
        //        case "home":
        //            user.home = user.home ?? "" + data
        //        default:
        //            break
        //        }
    }
    
    // 遇到结束标签时调用
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
        //标签User结束时将该用户对象，存入数组容器。
        //        if elementName == "User"{
        //            users.append(user)
        //        }
    }
}
