//
//  RequestValidation.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
protocol RequestValidation{
    func getHeaders()->[FieldKey:String]
    func getBody()->[FieldKey:Any]
    func getQueries()->[FieldKey:String]
    func getRequestContract()->[RequiredContractType:[FieldKey:Bool]]
    func validateFieldData(_field:FieldKey,value:Any)->[InstagramCloneExceptions]?
    func validateRequestContract()->[FieldKey:[InstagramCloneExceptions]]
}

//MARK: -Shared functions with default implementations
extension RequestValidation{

    func validateRequestContract() -> [FieldKey:[InstagramCloneExceptions]]{
        let contractMap = getRequestContract()
        let contractValuesMap = buildContractValuesMap()
        
        var errorMap = validateReuiredKeys(values: contractValuesMap, contract: contractMap)
        let optionalErrors = validateOptionalKeys(values: contractValuesMap, contract: contractMap)
        errorMap.merge(optionalErrors){_,new in new}
        
        return errorMap
    }
    
    private func buildContractValuesMap()->[FieldKey:Any]{
        var contractMap : [FieldKey:Any]  = [:]
        let body = getBody()
        let headers = getHeaders()
        let queries = getQueries()
        contractMap.merge(body){_,new in new }
        contractMap.merge(headers){_,new in new }
        contractMap.merge(queries){_,new in new }
        return contractMap
    }
    private func validateReuiredKeys(values:[FieldKey:Any],contract:[RequiredContractType:[FieldKey:Bool]])->[FieldKey:[InstagramCloneExceptions]]{
        var errorMap : [FieldKey:[InstagramCloneExceptions]] = [:]
        for type in contract.values{
            type.forEach{(field,isRequired) in
                if isRequired{
                    let fieldValue = values[field]
                    if !values.keys.contains(field){
                        errorMap[field,default: []].append(InstagramCloneExceptions.requestValidation(.missingRequiredKey(fieldKey: field.rawValue)))
                    }
                    if fieldValue == nil {
                        errorMap[field,default: []].append(InstagramCloneExceptions.requestValidation(.nilRequiredValue(fieldKey: field.rawValue)))
                    }
                    if let fieldValue , let fieldErrors = validateFieldData(_field: field, value: fieldValue){
                        errorMap[field,default: []].append(contentsOf:fieldErrors)
                    }
                    
                }
            }
            
            
        }
        return errorMap
    }

   private func validateOptionalKeys(values:[FieldKey:Any],contract:[RequiredContractType:[FieldKey:Bool]])->[FieldKey:[InstagramCloneExceptions]]{
        var errorMap:[FieldKey:[InstagramCloneExceptions]]=[:]
        for type in contract.values{
            type.forEach{(field,isRequired) in
                guard !isRequired else {return}
                if let fieldValue = values[field]{
                    guard let fieldError = validateFieldData(_field: field, value: fieldValue) else {return}
                    errorMap[field,default: []].append(contentsOf:fieldError)
                }
            }
        }
        return errorMap
    }

}
