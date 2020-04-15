//
//  SystemMessageCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class SystemMessageCell: BubbleMessageCell {

    /**
     *  系统消息标签
     *  用于展示系统消息的内容。例如：“您撤回了一条消息”。
     */
    var messageLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 13)
        $0.textColor = NSColor(red: 148.0 / 255.0, green: 149.0 / 255.0, blue: 149.0 / 255.0, alpha: 1.0)
        $0.alignment = .center
        $0.maximumNumberOfLines = 0
        $0.backgroundColor = .clear
        $0.layer?.cornerRadius = 3
        $0.layer?.masksToBounds = true
    }

    /**
     *  系统消息单元数据源
     *  消息源中存放了系统消息的内容、消息字体以及消息颜色。
     *  详细信息请参考 Section\Chat\CellData\TUISystemMessageCellData.h
     */
    var systemData: TUISystemMessageCellData?

    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        container.addSubview(messageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  填充数据
     *  根据 data 设置系统消息的数据
     *
     *  @param data 填充数据需要的数据源
     */
    override func fill(withData data: TCommonCellData) {
        super.fill(withData: data)
        guard let systemData = data as? TUISystemMessageCellData else {
            return
        }
        
        self.systemData = systemData
        //set data
        self.messageLabel.stringValue = systemData.content ?? ""
        self.nameLabel.isHidden = true
        self.avatarView.isHidden = true
        self.layoutSubtreeIfNeeded()
    }
    
    override func layout() {
        super.layout()
        if let superview = self.container.superview {
            let center = CGPoint(x: superview.width / 2, y: superview.height / 2)
            self.container.center = center
        }
        if let superview = self.messageLabel.superview {
            self.messageLabel.frame = CGRect(x: 0, y: 0, width: superview.width, height: superview.height)
        }
    }
}
