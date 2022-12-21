//
//  Orderrequest1.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 03/11/22.
//

import Foundation

// This is just a sample order request class
// Check docs for all possible fields available
struct Orderrequest1: Encodable
{
    let action: String
    let amount: Orderamount1
    let emailAddress: String
    let firstname: String
    let lastname: String
   
    
    private enum  OrderRequestCodingKeys: String, CodingKey {
        case action
        case amount
        case emailAddress
        case firstname
        case lastname
    }
}
