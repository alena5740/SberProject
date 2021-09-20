//
//  BirthdayFormatter.swift
//  SberProject
//
//  Created by Алена on 14.09.2021.
//

import Foundation

// Extension для String с функцией форматирования даты
extension String {
    public func birthdayFormatter() -> String {
        let monthArray = ["1": "января", "2": "февраля", "3": "марта", "4": "апреля", "5": "мая", "6": "июня", "7": "июля", "8": "августа", "9": "сентября", "10": "октября", "11": "ноября", "12": "декабря"]
        
        let dateArray = self.components(separatedBy: ".")
        let date = dateArray[0]
        let month = dateArray[1]
        var result = ""
        
        for (monthNumber, monthName) in monthArray {
            if month == monthNumber {
                result = "\(date) \(monthName)"
            }
        }
        return result
    }
}
