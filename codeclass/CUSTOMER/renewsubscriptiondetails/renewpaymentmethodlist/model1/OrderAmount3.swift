//
//  OrderAmount3.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/12/22.
//

import Foundation

struct OrderAmount3: Encodable {
    let currencyCode: String?
    let value: Int?
    
    private enum AmountCodingKeys: String, CodingKey {
        case currencyCode
        case value
    }
}


/*struct OrdersavedCard: Encodable {
    let cardToken: String?
    let cardholderName: String?
    let expiry: String?
    let maskedPan: String?
    let scheme: String?
   // let cvv: String?
    
    private enum OrdersavedCardCodingKeys: String, CodingKey {
        case cardToken
        case cardholderName
        case expiry
        case maskedPan
        case scheme
       
    }
}
*/


/*
struct OrderbillingAddress: Encodable {
    let firstName: String?
    let lastName: String?
    let address1: String?
    let city: String?
    let countryCode: String?
    
    private enum OrderbillingAddressCodingKeys: String, CodingKey {
        case firstName
        case lastName
        case address1
        case city
        case countryCode
       
    }
}
*/

