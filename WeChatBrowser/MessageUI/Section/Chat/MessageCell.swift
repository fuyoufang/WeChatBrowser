//
//  MessageCell.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import Then
class MessageCell: CommonCell {

    // MARK: properties
    var messageData: UIMessageCellData?

    
    // MARK: UI
    
    // 头像视图
    private let avatarView = NSImageView().then {
        $0.imageAlignment = .alignCenter
        $0.layer?.masksToBounds = true
        $0.layer?.cornerRadius = 4
    }
    
    // 昵称标签
    private let nameLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 13)
        $0.textColor = .gray
    }
    
    /**
     *  容器视图。
     *  包裹了 MesageCell 的各类视图，作为 MessageCell 的“底”，方便进行视图管理与布局。
     */
    private let container = NSView().then {
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
        layer?.backgroundColor = .clear
        
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(container)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fill(withData data: CommonCellData) {
        super.fill(withData: data)
        guard let messageData = data as? UIMessageCellData else {
            return
        }
        self.messageData = messageData
        
        avatarView.image = messageData.avatarImage
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
    }
    
//    - (void)layoutSubviews
//    {
//        [super layoutSubviews];
//        if (self.messageData.showName) {
//            _nameLabel.mm_sizeToFitThan(1, 20);
//            _nameLabel.hidden = NO;
//        } else {
//            _nameLabel.hidden = YES;
//            _nameLabel.mm_height(0);
//        }
//        
//        TUIMessageCellLayout *cellLayout = self.messageData.cellLayout;
//        if (self.messageData.direction == MsgDirectionIncoming) {
//            self.avatarView.mm_x = cellLayout.avatarInsets.left;
//            self.avatarView.mm_y = cellLayout.avatarInsets.top;
//            self.avatarView.mm_w = cellLayout.avatarSize.width;
//            self.avatarView.mm_h = cellLayout.avatarSize.height;
//            
//            self.nameLabel.mm_top(self.avatarView.mm_y);
//            
//            CGSize csize = [self.messageData contentSize];
//            CGFloat ctop = cellLayout.messageInsets.top + _nameLabel.mm_h;
//            self.container.mm_left(cellLayout.messageInsets.left+self.avatarView.mm_maxX)
//            .mm_top(ctop).mm_width(csize.width).mm_height(csize.height);
//            
//            self.nameLabel.mm_left(_container.mm_x + 7) ;//与气泡对齐
//            self.indicator.mm_sizeToFit().mm__centerY(_container.mm_centerY).mm_left(_container.mm_maxX + 8);
//            self.retryView.frame = self.indicator.frame;
//            self.readReceiptLabel.hidden = YES;
//            
//        } else {
//            
//            self.avatarView.mm_w = cellLayout.avatarSize.width;
//            self.avatarView.mm_h = cellLayout.avatarSize.height;
//            self.avatarView.mm_top(cellLayout.avatarInsets.top).mm_right(cellLayout.avatarInsets.right);
//            
//            self.nameLabel.mm_top(self.avatarView.mm_y);
//            
//            CGSize csize = [self.messageData contentSize];
//            CGFloat ctop = cellLayout.messageInsets.top + _nameLabel.mm_h;
//            self.container.mm_width(csize.width).mm_height(csize.height)
//            .mm_right(cellLayout.messageInsets.right+self.mm_w-self.avatarView.mm_x).mm_top(ctop);
//            
//            self.nameLabel.mm_right(_container.mm_r);
//            self.indicator.mm_sizeToFit().mm__centerY(_container.mm_centerY).mm_left(_container.mm_x - 8 - _indicator.mm_w);
//            self.retryView.frame = self.indicator.frame;
//            //这里不能像 retryView 一样直接使用 indicator 的设定，否则内容会显示不全。
//            self.readReceiptLabel.mm_sizeToFitThan(0,self.indicator.mm_w).mm_bottom(self.container.mm_b + cellLayout.bubbleInsets.bottom).mm_left(_container.mm_x - 8 - _indicator.mm_w);
//            
//        }
//    }
//
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
