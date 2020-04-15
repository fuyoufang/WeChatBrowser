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
        dateFmt.amSymbol = "上午"
        dateFmt.pmSymbol = "下午"

        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: self)
        
        if nowCmps.year != myCmps.year {
            dateFmt.dateFormat = "yyyy/MM/dd aaahh:mm"
        } else {
            let components = Calendar.current.dateComponents([.day], from: self, to: Date())

            let day = components.day ?? 0
            if day == 0 {
                dateFmt.dateFormat = "aaahh:mm"
            } else if day == 1 {
                dateFmt.dateFormat = "昨天aaahh:mm"
            } else {
                if day <= 7 {
                    switch (comp.weekday) {
                        case 1:
                            dateFmt.dateFormat = "星期日 aaahh:mm"
                        case 2:
                            dateFmt.dateFormat = "星期一 aaahh:mm"
                        case 3:
                            dateFmt.dateFormat = "星期二 aaahh:mm"
                        case 4:
                            dateFmt.dateFormat = "星期三 aaahh:mm"
                        case 5:
                            dateFmt.dateFormat = "星期四 aaahh:mm"
                        case 6:
                            dateFmt.dateFormat = "星期五 aaahh:mm"
                        case 7:
                            dateFmt.dateFormat = "星期六 aaahh:mm"

                        default:
                            break
                    }
                } else {
                    dateFmt.dateFormat = "yyyy/MM/dd aaahh:mm"
                }
            }
        }
        return dateFmt.string(from: self)
    }
}
