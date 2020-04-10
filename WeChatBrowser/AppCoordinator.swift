//
//  AppCoordinator.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

final class AppCoordinator {
    var windowController: MainWindowController
    let vc = ViewController()
    
    init(windowController: MainWindowController) {
        self.windowController = windowController
        
        windowController.contentViewController = vc
        windowController.showWindow(self)

        _ = NotificationCenter.default.addObserver(forName: NSApplication.didFinishLaunchingNotification, object: nil, queue: nil) { _ in self.startup() }

    }
    
    private func startup() {
        windowController.contentViewController = vc
        windowController.showWindow(self)
    }

}
