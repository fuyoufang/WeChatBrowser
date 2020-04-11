//
//  ViewController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa
import SnapKit

class ViewController: NSViewController {

    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFilePath = "/Users/fuyoufang/Downloads/WeChatApp/8DFF768D-9664-4368-8646-C280DA647D91"
        let imManager = TIMManager(filePath: textFilePath)
        
        let usersMessageViewController = UsersMessageViewController(windowController: MainWindowController(), imManager: imManager)
        setupSubviews(usersMessageViewController)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: setup UI
    func setupSubviews(_ usersMessageViewController: UsersMessageViewController) {
        addChild(usersMessageViewController)
        view.addSubview(usersMessageViewController.view)
        
        usersMessageViewController.view
            .snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }


}

