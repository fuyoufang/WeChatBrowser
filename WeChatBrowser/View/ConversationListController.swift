//
//  ConversationListController.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/10.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Cocoa

class SessionViewModel {
    
}

class ConversationListController: NSViewController, NSMenuItemValidation {
    
    // MARK: Properies
    var viewModel: TConversationListViewModel = {
        let model = TConversationListViewModel()
        model.listFilter = { data -> Bool in
            return data.convType != .SYSTEM
        }
        return model
    }()
    
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
    

    init() {
        super.init(nibName: nil, bundle: nil)

        identifier = NSUserInterfaceItemIdentifier(rawValue: "videosList")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: MainWindowController.defaultRect.height))
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkWindowBackground.cgColor
        view.widthAnchor.constraint(lessThanOrEqualToConstant: 675).isActive = true

        scrollView.frame = view.bounds
        tableView.frame = view.bounds

        scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 320).isActive = true

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.width.equalToSuperview()
        }
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
  
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        view.window?.makeFirstResponder(tableView)
    }

    // MARK: - UI

    lazy var tableView: TableView = {
        let v = TableView()

        // We control the intial selection during initialization
        v.allowsEmptySelection = true
        v.wantsLayer = true
        v.focusRingType = .none
        v.backgroundColor = .listBackground
        v.headerView = nil
        v.rowHeight = Metrics.sessionRowHeight
        v.autoresizingMask = [.width, .height]
        v.floatsGroupRows = true
        v.gridStyleMask = .solidHorizontalGridLineMask
        v.gridColor = .darkGridColor
        v.allowsMultipleSelection = false
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "session"))
        v.addTableColumn(column)

        return v
    }()

    lazy var scrollView: NSScrollView = {
        let v = NSScrollView()

        v.focusRingType = .none
//        v.backgroundColor = .listBackground
        v.wantsLayer = true
        v.backgroundColor = .red
        v.borderType = .noBorder
        v.documentView = self.tableView
        v.hasVerticalScroller = true
        v.hasHorizontalScroller = false
        v.translatesAutoresizingMaskIntoConstraints = false
//        v.alphaValue = 0
        return v
    }()

    // MARK: - Contextual menu

    fileprivate enum ContextualMenuOption: Int {
        case watched = 1000
        case unwatched = 1001
        case favorite = 1002
        case removeFavorite = 1003
        case download = 1004
        case cancelDownload = 1005
        case revealInFinder = 1006
    }

    private func selectedAndClickedRowIndexes() -> IndexSet {
        let clickedRow = tableView.clickedRow
        let selectedRowIndexes = tableView.selectedRowIndexes

        if clickedRow < 0 || selectedRowIndexes.contains(clickedRow) {
            return selectedRowIndexes
        } else {
            return IndexSet(integer: clickedRow)
        }
    }
    
    let displayedRows = [SessionViewModel(), SessionViewModel()]
}

// MARK: - Datasource / Delegate

extension ConversationListController: NSTableViewDataSource, NSTableViewDelegate {

    fileprivate struct Metrics {
        static let headerRowHeight: CGFloat = 20
        static let sessionRowHeight: CGFloat = 64
    }

    private struct Constants {
        static let sessionCellIdentifier = "sessionCell"
        static let titleCellIdentifier = "titleCell"
        static let rowIdentifier = "row"
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.dataList.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let model = SessionViewModel()
        return cellForSessionViewModel(model)
    }

    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var rowView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier), owner: tableView) as? TableRowView

        if rowView == nil {
            rowView = TableRowView(frame: .zero)
            rowView?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.rowIdentifier)
        }

        return rowView
    }
    
    private func cellForSessionViewModel(_ viewModel: SessionViewModel) -> ConversationListView? {
        var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier), owner: tableView) as? ConversationListView
        
        if cell == nil {
            cell = ConversationListView(frame: .zero)
            cell?.identifier = NSUserInterfaceItemIdentifier(rawValue: Constants.sessionCellIdentifier)
        }
        
        return cell
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return Metrics.sessionRowHeight
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }

    func tableView(_ tableView: NSTableView, isGroupRow row: Int) -> Bool {
        return false
    }
    
    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {

        debugPrint(tableView.selectedRow)
        
    }

}
