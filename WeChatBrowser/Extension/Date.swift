//
//  Date.swift
//  WeChatBrowser
//
//  Created by fuyoufang on 2020/4/13.
//  Copyright © 2020 fuyoufang. All rights reserved.
//

import Foundation

extension Date {
    func tk_messageString() -> String {
    
        let calendar = NSCalendar.current
        let unit: Set<Calendar.Component> = [.day, .month, .year]
        let nowCmps = calendar.dateComponents(unit, from: Date())
            
        let myCmps = calendar.dateComponents(unit, from: self)
        let dateFmt = DateFormatter()
        

        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: self)
        
        if nowCmps.year != myCmps.year {
            dateFmt.dateFormat = "yyyy/MM/dd"
        } else {
            let day = (nowCmps.day ?? 0) - (myCmps.day ?? 0)
            if day == 0 {
                dateFmt.dateFormat = "HH:mm"
            } else if day == 1 {
                dateFmt.amSymbol = "上午"
                dateFmt.pmSymbol = "下午"
                dateFmt.dateFormat = "昨天"
            } else {
                if day <= 7 {
                    switch (comp.weekday) {
                        case 1:
                            dateFmt.dateFormat = "星期日"

                        case 2:
                            dateFmt.dateFormat = "星期一"

                        case 3:
                            dateFmt.dateFormat = "星期二"

                        case 4:
                            dateFmt.dateFormat = "星期三"

                        case 5:
                            dateFmt.dateFormat = "星期四"

                        case 6:
                            dateFmt.dateFormat = "星期五"

                        case 7:
                            dateFmt.dateFormat = "星期六"

                        default:
                            break
                    }
                } else {
                    dateFmt.dateFormat = "yyyy/MM/dd"
                }
            }
        }
        return dateFmt.string(from: self)
    }
}
