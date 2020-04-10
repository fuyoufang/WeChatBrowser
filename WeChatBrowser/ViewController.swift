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

    let usersMessageViewController = UsersMessageViewController(windowController: MainWindowController())
    
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: setup UI
    func setupSubviews() {
        addChild(usersMessageViewController)
        view.addSubview(usersMessageViewController.view)
        
        usersMessageViewController.view
            .snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }


}

