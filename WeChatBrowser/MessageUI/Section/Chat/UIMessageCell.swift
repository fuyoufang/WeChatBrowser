//
//  MessageCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import Then
import Kingfisher

class UIMessageCell: CommonCell {

    // MARK: properties
    var messageData: TUIMessageCellData?

    
    // MARK: UI
    
    // 头像视图
    let avatarView = NSImageView().then {
        $0.imageAlignment = .alignCenter
        $0.layer?.masksToBounds = true
        $0.layer?.cornerRadius = 4
    }
    
    // 昵称标签
    let nameLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 13)
        $0.textColor = .gray
    }
    
    /**
     *  容器视图。
     *  包裹了 MesageCell 的各类视图，作为 MessageCell 的“底”，方便进行视图管理与布局。
     */
    let container = NSView().then {
        $0.wantsLayer = true
        $0.layer?.backgroundColor = .clear
    }
    private let readReceiptLabel = Label()

    /**
     *  信息数据类。
     *  存储了该massageCell中所需的信息。包括发送者 ID，发送者头像、信息发送状态、信息气泡图标等。
     *  messageData 详细信息请参考：Section\Chat\CellData\TUIMessageCellData.h
     */
//    @property (readonly) TUIMessageCellData *messageData;

    /**
     *  单元填充函数
     *  根据data填充消息单元
     *
     *  @param  data 填充数据源
     */
//    - (void)fillWithData:(TCommonCellData *)data;
    
    
    // MARK: initialize
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(container)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fill(withData data: TCommonCellData) {
        super.fill(withData: data)
        guard let messageData = data as? TUIMessageCellData else {
            return
        }
        self.messageData = messageData
        
        avatarView.image = messageData.avatarImage
        avatarView.kf.setImage(with: messageData.avatarUrl)
        nameLabel.stringValue = messageData.name ?? ""
        nameLabel.textColor = messageData.nameColor
        nameLabel.font = messageData.nameFont
    }

    override func layout() {
        super.layout()
        guard let messageData = self.messageData else {
            return
        }
        if messageData.showName {
            nameLabel.isHidden = false
            nameLabel.sizeToFit()
        } else {
            nameLabel.isHidden = false
            nameLabel.height = 0
        }
        let cellLayout = messageData.cellLayout

        if messageData.direction == .incoming {
            avatarView.x = cellLayout.avatarInsets.left
            avatarView.y = cellLayout.avatarInsets.top
            avatarView.width = cellLayout.avatarSize.width
            avatarView.height = cellLayout.avatarSize.height
            
            nameLabel.y = avatarView.y

            let csize = messageData.contentSize()
             let ctop = cellLayout.messageInsets.top + nameLabel.height;
            
            container.x = cellLayout.messageInsets.left + avatarView.maxX
            container.y = ctop
            container.width = csize.width
            container.height = csize.height
             
            nameLabel.x = container.x + 7
        } else {
            avatarView.width = cellLayout.avatarSize.width
            avatarView.height = cellLayout.avatarSize.height
            avatarView.y = cellLayout.avatarInsets.top
            avatarView.right = cellLayout.avatarInsets.right
            
            nameLabel.x = avatarView.y
            
            let csize = messageData.contentSize()
            let ctop = cellLayout.messageInsets.top + nameLabel.height
            
            container.width = csize.width
            container.height = csize.height
            container.right = cellLayout.messageInsets.right + self.width - avatarView.x
            container.y = ctop
            
            nameLabel.right = container.right
        }        
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
