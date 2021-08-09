//
//  String.swift
//  MovieAPP
//
//  Created by Daniel Mondragón on 07/08/21.
//
import UIKit
public extension String {
    func minutesToHoursAndMinutes (_ minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    func toMovementDate(date: String) -> String {
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "d MMM y"
        formatterDay.timeZone = TimeZone.current
        let firstDate = DateFormatter()
        firstDate.dateFormat = "yyyy-MM-dd"
        firstDate.locale = Locale(identifier: "MXN")
        if let dateTest = firstDate.date(from: date) as NSDate? {
            return formatterDay.string(from: dateTest as Date)
        } else {
            return ""
        }
    }
}
