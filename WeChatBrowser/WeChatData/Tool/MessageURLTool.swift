//
//  WebURLMessageTool.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

class MessageURLTool: NSObject {
    
    var messageURL: MessageURL?
    private let message: String
    //当前元素名
    private var currentElement: String?
    
    init(message: String) {
        var text = message.replacingOccurrences(of: "\n", with: "")
        text = text.replacingOccurrences(of: "\t", with: "")
        self.message = text
    }
    
    class func messageURL(message: String) -> MessageURL? {
        return MessageURLTool(message: message).getMessageURL()
    }
    
    func getMessageURL() -> MessageURL? {
        guard let data = message.data(using: .utf8) else {
            return nil
        }
        
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return messageURL
    }
    
    
}

extension MessageURLTool: XMLParserDelegate {
    // 遇到一个开始标签时调用
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "msg" {
            self.messageURL = MessageURL()
        }
    }
    
    // 遇到字符串时调用
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard let messageURL = self.messageURL else {
            return
        }
        
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        // 接下来每遇到一个字符，将该字符追加到相应的 property 中
        switch currentElement {
        case "title":
            messageURL.title = data
        case "des":
            messageURL.des = data
        case "type":
            messageURL.type = data
        case "showtype":
            messageURL.showtype = data
        case "soundtype":
            messageURL.soundtype = data
        case "contentattr":
            messageURL.contentattr = data
        case "url":
            messageURL.url = data
        case "cdnthumburl":
            messageURL.cdnthumburl = data
        case "cdnthumbmd5":
            messageURL.cdnthumbmd5 = data
        case "cdnthumblength":
            messageURL.cdnthumblength = data
        case "cdnthumbwidth":
            messageURL.cdnthumbwidth = data
        case "cdnthumbheight":
            messageURL.cdnthumbheight = data
        case "cdnthumbaeskey":
            messageURL.cdnthumbaeskey = data
        case "aeskey":
            messageURL.aeskey = data
        case "encryver":
            messageURL.encryver = data
        case "filekey":
            messageURL.filekey = data
        case "thumburl":
            messageURL.thumburl = data
        case "directshare":
            messageURL.directshare = data
        default:
            break
        }
    }
    
    // 遇到结束标签时调用
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
    }
}

