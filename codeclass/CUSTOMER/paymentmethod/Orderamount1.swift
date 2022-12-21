//
//  Orderamount1.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/11/22.
//

import Foundation

struct Orderamount1: Encodable {
    let currencyCode: String?
    let value: Int?
    
    private enum AmountCodingKeys: String, CodingKey {
        case currencyCode
        case value
    }
}
