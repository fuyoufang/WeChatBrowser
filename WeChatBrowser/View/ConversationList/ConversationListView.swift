//
//  ConversationListView.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import Kingfisher
class ConversationListView: NSTableCellView {
    
    var cellData: TUIConversationCellData? {
        didSet {
            titleLabel.stringValue = self.cellData?.title ?? ""
            avatarImageView.kf.setImage(with: self.cellData?.avatarUrl)
            subTitleLabel.stringValue = self.cellData?.subTitle ?? ""
            timeLabel.stringValue = self.cellData?.time?.tk_messageString() ?? ""
        }
    }
    
    // MARK: UI

    let titleLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 14)
        $0.textColor = NSColor.black
        $0.maximumNumberOfLines = 1
    }
    let avatarImageView = NSImageView()
    
    let subTitleLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 14)
        $0.textColor = NSColor(red: 178.0 / 255.0, green: 178.0 / 255.0, blue: 178.0 / 255.0, alpha: 1)
        $0.maximumNumberOfLines = 1
    }
    
    let timeLabel = Label().then {
        $0.font = NSFont.systemFont(ofSize: 14)
        $0.textColor = NSColor(red: 178.0 / 255.0, green: 178.0 / 255.0, blue: 178.0 / 255.0, alpha: 1)
    }
    
    // MARK: Initialize
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor(red: 251.0 / 255.0,
                                         green: 251.0 / 255.0,
                                         blue: 251.0 / 255.0,
                                         alpha: 1).cgColor
        layer?.opacity = 1.0
        layer?.isOpaque = true
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(avatarImageView)
        addSubview(subTitleLabel)
        addSubview(timeLabel)
        
        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 44, height: 44))
            $0.left.equalTo(10)
            $0.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(avatarImageView.snp.right).offset(10)
            $0.top.equalTo(avatarImageView)
            $0.right.equalTo(timeLabel.snp.left).offset(-10)
        }
        
        timeLabel.snp.makeConstraints {
            $0.right.equalTo(-12)
            $0.centerY.equalTo(titleLabel)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel)
            $0.bottom.equalTo(avatarImageView)
            $0.right.equalTo(timeLabel)
        }
        
        timeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
}
