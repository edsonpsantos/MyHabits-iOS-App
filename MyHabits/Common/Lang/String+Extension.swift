//
//  String+Extension.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 24/08/2023.
//

import Foundation

extension String {
    
    func isEmail()-> Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String?{
        //Get a string dd/MM/yyyy -> date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        //Date validate
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        //Date -> yyyy-MM-dd -> String
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
}
