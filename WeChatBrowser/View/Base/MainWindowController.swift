//
//  MainWindowController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

final class MainWindowController: WWDCWindowController {

    static var defaultRect: NSRect {
        return NSScreen.main?.visibleFrame.insetBy(dx: 50, dy: 120) ??
               NSRect(x: 0, y: 0, width: 1200, height: 600)
    }
    public var sidebarInitWidth: CGFloat?

    override func loadWindow() {
        let mask: NSWindow.StyleMask = [.titled, .resizable, .miniaturizable, .closable, .fullSizeContentView]
        let window = WWDCWindow(contentRect: MainWindowController.defaultRect, styleMask: mask, backing: .buffered, defer: false)

        window.title = "WWDC"

        window.center()

        window.identifier = .mainWindow
        window.setFrameAutosaveName("main")
        window.minSize = NSSize(width: 1060, height: 700)

        self.window = window
    }

}

extension NSUserInterfaceItemIdentifier {

    static let mainWindow = NSUserInterfaceItemIdentifier(rawValue: "main")
}


class WWDCWindowController: NSWindowController {


    override var windowNibName: NSNib.Name? {
        // Triggers `loadWindow` to be called so we can override it
        return NSNib.Name("")
    }

    init() {
        super.init(window: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadWindow() {
        fatalError("loadWindow must be overriden by subclasses")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

//        window?.appearance = WWDCAppearance.appearance()
//        window?.titleVisibility = .hidden
//        window?.addTitlebarAccessoryViewController(titleBarViewController)
//        window?.toolbar = NSToolbar(identifier: "DummyToolbar")
    }
}


class WWDCWindow: NSWindow {

    // MARK: - Initialization

    public override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)

        applyCustomizations()
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        applyCustomizations()
    }

    // MARK: - Custom appearance

    fileprivate var _storedTitlebarView: NSVisualEffectView?
    open var titlebarView: NSVisualEffectView? {
        guard _storedTitlebarView == nil else { return _storedTitlebarView }
        guard let containerClass = NSClassFromString("NSTitlebarContainerView") else { return nil }

        guard let containerView = contentView?.superview?.subviews.reversed().first(where: { $0.isKind(of: containerClass) }) else { return nil }

        guard let titlebar = containerView.subviews.reversed().first(where: { $0.isKind(of: NSVisualEffectView.self) }) as? NSVisualEffectView else { return nil }

        _storedTitlebarView = titlebar

        return _storedTitlebarView
    }

    fileprivate func applyCustomizations(_ note: Notification? = nil) {
        backgroundColor = .darkWindowBackground

        titleVisibility = .hidden
        isMovableByWindowBackground = true
        tabbingMode = .disallowed

        titlebarView?.material = .ultraDark
        titlebarView?.state = .inactive
        titlebarView?.layer?.backgroundColor = NSColor.darkTitlebarBackground.cgColor
    }
}
