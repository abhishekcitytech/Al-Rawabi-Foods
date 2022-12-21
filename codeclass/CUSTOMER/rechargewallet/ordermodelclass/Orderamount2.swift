//
//  Orderamount2.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 29/11/22.
//

import Foundation

struct Orderamount2: Encodable {
    let currencyCode: String?
    let value: Int?
    
    private enum AmountCodingKeys: String, CodingKey {
        case currencyCode
        case value
    }
}
