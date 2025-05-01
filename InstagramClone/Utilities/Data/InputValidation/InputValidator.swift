//
//  InputValidator.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
class InputValidator {
    func isValidString(string:String)->Bool{
        return !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateStringFieldKey(string:String,fieldKey:String)->InstagramCloneExceptions?{
        if !isValidString(string: string){
            return InstagramCloneExceptions.requestValidation(.emptyString(fieldKey: fieldKey))
        }
        return nil
    }
}
