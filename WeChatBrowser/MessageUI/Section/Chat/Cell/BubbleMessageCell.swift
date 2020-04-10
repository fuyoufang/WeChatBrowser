//
//  BubbleMessageCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class BubbleMessageCell: UIMessageCell {

    // MARK: Properties
    /**
     *  气泡单元数据源
     *  气泡单元数据源中存放了气泡的各类图标，比如接收图标（正常与高亮）、发送图标（正常与高亮）。
     *  并能根据具体的发送、接收状态选择相应的图标进行显示。
     */
    var bubbleData: TUIBubbleMessageCellData?
    
    // MARK: UI
    /**
     *  气泡图像视图，即消息的气泡图标，在 UI 上作为气泡的背景板包裹消息信息内容。
     */
    var bubbleView = NSImageView()

    // MARK: Initialize
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        container.addSubview(bubbleView)
        bubbleView.autoresizingMask = [.width, .height]
//        _bubbleView.mm_fill();
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /**
     *  填充数据
     *  根据 data 设置气泡消息的数据。
     *
     *  @param data 填充数据需要的数据源
     */
    override func fill(withData data: TCommonCellData) {
        super.fill(withData: data)
        guard let bubbleData = data as? TUIBubbleMessageCellData else {
            return
        }
        self.bubbleData = bubbleData
        self.bubbleView.image = bubbleData.bubble
        // self.bubbleView.highlightedImage = bubbleData.highlightedBubble

    }
    
    override func layout() {
        super.layout()
        guard let bubbleData = self.bubbleData else {
            return
        }
        bubbleView.x = bubbleData.bubbleTop
    }

}
