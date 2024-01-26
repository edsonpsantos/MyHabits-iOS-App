//
//  Mask.swift
//  MyHabits
//
//  Created by EDSON SANTOS on 26/01/2024.
//

import Foundation

class Mask {
    
    static var isUpdating = false
    static var oldString = ""
    
    private static func replaceChars(full: String) -> String {
        full.replacingOccurrences(of:".", with: "")
            .replacingOccurrences(of:"-", with: "")
            .replacingOccurrences(of:"(", with: "")
            .replacingOccurrences(of:")", with: "")
            .replacingOccurrences(of:"/", with: "")
            .replacingOccurrences(of:"*", with: "")
            .replacingOccurrences(of:" ", with: "")
    }
    
    static func mask(mask: String, value: String , text: inout String) {
        
        let str = Mask.replaceChars(full: value)
        var fieldWithMask = ""
        
        let _mask = mask
        
        /* code to Brazil setup phone
        //if(mask == "(##) ####-####"){
        //    if(value.count >= 14 && value.characterAtIndex(index: 5) == "9"){
        //        _mask = "(##) #####-####"
        //    }
        //}
       
        //deleting value in the form
        //if(str <= oldString){
        //    isUpdating = true
        //    if(_mask == "(##) #####-####" && value.count == 14){
        //        _mask = "(##) ####-####"
        //    }
        //}
         */
        
        //deleting value in the form
        if(str <= oldString){
            isUpdating = true
        }
        
        if(isUpdating || value.count == mask.count){
            oldString = str
            isUpdating = false
            return
        }
        
        var i = 0
        for char in _mask {
            if (char != "#" && str.count > oldString.count){
                fieldWithMask = fieldWithMask + String(char)
                continue
            }
            let unNamed = str.characterAtIndex(index: i)
            guard let char = unNamed else { break }
            
            fieldWithMask = fieldWithMask + String(char)
            
            i = i + 1
        }
        isUpdating = true
        if(fieldWithMask == "(0"){
            text = ""
            return
        }
        text = fieldWithMask
    }
}
