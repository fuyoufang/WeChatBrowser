//
//  main.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
import Cocoa

/// 我们需要先初始化AppDelegate，并强引用该对象防止其释放
let delegate = AppDelegate()
/// 将delegate赋值
NSApplication.shared.delegate = delegate
/// 调用NSApplicationMain 传入外界的入参
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

