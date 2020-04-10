//
//  SqliteMaster.swift
//  WeChatMessageManager
//
//  Created by fuyoufang on 2020/4/8.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation
import WCDBSwift

class SqliteMaster: TableCodable {
    var name: String?
    var type: String?
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = SqliteMaster
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case name
        case type
    }
}
