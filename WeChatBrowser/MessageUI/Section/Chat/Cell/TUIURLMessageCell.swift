//
//  TUITextMessageCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/16.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import Kingfisher

class TUIURLMessageCell: BubbleMessageCell {
    
    var title = Label().then {
        $0.maximumNumberOfLines = 2
    }
    
    var detail = Label().then {
        $0.maximumNumberOfLines = 3
    }
    
    var image = NSImageView()

    /**
     *  文本消息单元数据源
     *  数据源内存放了文本消息的内容信息、消息字体、消息颜色、并存放了发送、接收两种状态下的不同字体颜色。
     */
    var urlData: TUIURLMessageCellData?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        bubbleView.addSubview(title)
        bubbleView.addSubview(detail)
        bubbleView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  填充数据
     *  根据 data 设置文本消息的数据。
     *
     *  @param  data    填充数据需要的数据源
     */
    override func fill(withData data: TCommonCellData) {
        super.fill(withData: data)
        
        guard let urlData = data as? TUIURLMessageCellData else {
            return
        }
        self.urlData = urlData
        self.title.attributedStringValue = urlData.titleAttributedString
        self.title.textColor = urlData.titleColor
        self.detail.attributedStringValue = urlData.detailAttributedString
        self.detail.textColor = urlData.detailColor
        self.image.kf.setImage(with: urlData.imageURL)
        self.bubbleView.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    override func layout() {
        super.layout()
        guard let urlData = self.urlData else {
            return
        }
        title.frame = CGRect(x: urlData.titleOrigin.x,
                             y: urlData.titleOrigin.y,
                             width: urlData.titleSize.width,
                             height: urlData.titleSize.height)
        
        detail.frame = CGRect(x: urlData.detailOrigin.x,
                              y: urlData.detailOrigin.y,
                              width: urlData.detailSize.width,
                              height: urlData.detailSize.height)
        
        image.frame = CGRect(x: urlData.imageOrigin.x,
                             y: urlData.imageOrigin.y,
                             width: urlData.imageSize.width,
                             height: urlData.imageSize.height)
    }
}
