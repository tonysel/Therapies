//
//  TraslationManager.swift
//  Tesi
//
//  Created by TonySellitto on 19/05/18.
//  Copyright © 2018 TonySellitto. All rights reserved.
//

import UIKit

extension Date{
    func  getWeekDay(specificDate: Date) -> Int {
        let calendar: Calendar = Calendar.current
        let component  = calendar.component(Calendar.Component.weekday, from: specificDate)
        return component
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
}

public class TraslationManager{
    
    static func convertStringDateToArrayIntDate(dayInString: String ) -> [Int]{
        
        var arrayDate = [Int]()
        
        if (dayInString.count == 2){
            var i = 0
            
            for _ in 1...1{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                
                i = i + 3
                
            }
        }
            
        else if (dayInString.count == 5){
            var i = 0
            
            for _ in 1...2{
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                i = i + 3
            }
        }
        else if (dayInString.count == 8){
            var i = 0
            
            for _ in 1...3{
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                i = i + 3
            }
        }
            
        else if (dayInString.count == 11){
            var i = 0
            
            for _ in 1...4{
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                i = i + 3
            }
        }
            
        else if (dayInString.count == 14){
            var i = 0
            
            for _ in 1...5{
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                i = i + 3
            }
        }
            
            
            
        else if (dayInString.count == 17){
            var i = 0
            
            for _ in 1...6{
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                i = i + 3
            }
        }
            
            
        else if (dayInString.count == 20){
            var i = 0
            
            for _ in 1...7{
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append(2)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append(1)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append(3)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append(4)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append(5)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append(6)
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append(7)
                }
                i = i + 3
            }
        }
        
        return arrayDate
    }
    
    static func convertStringDateToArrayStringDate(dayInString: String ) -> [String]{
        
        var arrayDate = [String]()
        
        if (dayInString.count == 2){
            var i = 0
            
            for _ in 1...1{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
            
        else if (dayInString.count == 5){
            var i = 0
            
            for _ in 1...2{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
        else if (dayInString.count == 8){
            var i = 0
            
            for _ in 1...3{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
            
        else if (dayInString.count == 11){
            var i = 0
            
            for _ in 1...4{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
            
        else if (dayInString.count == 14){
            var i = 0
            
            for _ in 1...5{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
            
            
            
        else if (dayInString.count == 17){
            var i = 0
            
            for _ in 1...6{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
            
            
        else if (dayInString.count == 20){
            var i = 0
            
            for _ in 1...7{
                
                if (dayInString.substring(from: i, to: i + 2) == "LU"){
                    arrayDate.append("LU")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "DO"){
                    arrayDate.append("DO")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "MA"){
                    arrayDate.append("MA")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "ME"){
                    arrayDate.append("ME")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "GI"){
                    arrayDate.append("GI")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "VE"){
                    arrayDate.append("VE")
                }
                else if (dayInString.substring(from: i, to: i + 2) == "SA"){
                    arrayDate.append("SA")
                }
                
                i = i + 3
                
            }
        }
        
        return arrayDate
    }
    
    static func convertTimeInStringToDateArray(timeInString: String) -> [Date]{
        
        var i = 0
        
        var dateArray = [Date]()
        
        repeat{
            
            let specificTime = timeInString.substring(from: i, to: i + 5)
            
            let dateFormatter = DateFormatter.init()
//            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")!
            dateFormatter.dateFormat = "HH:mm"
            
            let date = dateFormatter.date(from: specificTime)!
            
            i = i + 6
            
            dateArray.append(date)
            
        } while(i <=  timeInString.count)
        
        return dateArray
    }

    
    static func loadDayName(forDate date: Date) -> String{
        let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let weekDay = calendar.component(.weekday, from: date)
        
        switch weekDay {
        case 1:
            return "Domenica"
        case 2:
            return "Lunedi"
        case 3:
            return "Martedi"
        case 4:
            return "Mercoledi"
        case 5:
            return "Giovedi"
        case 6:
            return "Venerdi"
        case 7:
            return "Sabato"
        default:
            return "Nada"
        }
    }
   
}
