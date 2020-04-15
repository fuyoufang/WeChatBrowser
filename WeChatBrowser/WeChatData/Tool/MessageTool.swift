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
    
    class func getImageElem(imageFilePath: String, message: String, index: Int) -> TIMImageElem? {
        guard let image = MessageImageTool(message: message).getImage() else {
            return nil
        }
        let imageList = MessageImageTool.getImageList(imageFilePath: imageFilePath, messageImage: image, index: index)
        let imageElem = TIMImageElem()
        imageElem.imageList = imageList
        return imageElem
    }
    
    class func imageList(imageFilePath: String, message: String, index: Int) -> [TIMImage] {
        guard let image = MessageImageTool(message: message).getImage() else {
            return []
        }
        return MessageImageTool.getImageList(imageFilePath: imageFilePath, messageImage: image, index: index)
    }
    
    class func getImageList(imageFilePath: String, messageImage: MessageImage, index: Int) -> [TIMImage] {
        var images = [TIMImage]()
        let thumbImage = TIMImage()
        thumbImage.uuid = messageImage.cdnthumbaeskey
        thumbImage.type = .THUMB
        if messageImage.cdnthumblength != nil {
            thumbImage.size = Int(messageImage.cdnthumblength!)
        }
        if messageImage.cdnthumbwidth != nil {
            thumbImage.width = Int(messageImage.cdnthumbwidth!)
        }
        if messageImage.cdnthumbheight != nil {
            thumbImage.height = Int(messageImage.cdnthumbheight!)
        }
        thumbImage.path = "\(imageFilePath)/\(index).pic_thum"
//        thumbImage.url = messageImage.cdnthumburl
        images.append(thumbImage)
        
        if messageImage.cdnbigimgurl != nil {
            let largeImage = TIMImage()
//            largeImage.url = messageImage.cdnbigimgurl
            largeImage.path = "\(imageFilePath)/\(index).pic"
            images.append(largeImage)
        }
        return images
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
        
    }
    
    // 遇到结束标签时调用
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        
    }
}
