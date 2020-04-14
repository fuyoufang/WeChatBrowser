//
//  TextMessageCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class TextMessageCell: BubbleMessageCell {

    /**
     *  内容标签
     *  用于展示文本消息的内容。
     */
    var content = Label().then {
        $0.maximumNumberOfLines = 0
    }

    /**
     *  文本消息单元数据源
     *  数据源内存放了文本消息的内容信息、消息字体、消息颜色、并存放了发送、接收两种状态下的不同字体颜色。
     */
    var textData: TUITextMessageCellData?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        bubbleView.addSubview(content)
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
        
        guard let textData = data as? TUITextMessageCellData else {
            return
        }
        self.textData = textData;
        self.content.attributedStringValue = textData.attributedString 
        self.content.textColor = textData.textColor;
    }
    
    override func layout() {
        super.layout()
        guard let textData = self.textData else {
            return
        }
        content.frame = CGRect(x: textData.textOrigin.x, y: textData.textOrigin.y, width: textData.textSize.width, height: textData.textSize.height)
    }
}
