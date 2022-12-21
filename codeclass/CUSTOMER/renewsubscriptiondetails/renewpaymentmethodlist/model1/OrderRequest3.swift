//
//  OrderRequest3.swift
//  AlRawabi
//
//  Created by SandipanMacmini on 01/12/22.
//

import Foundation

// This is just a sample order request class
// Check docs for all possible fields available
struct OrderRequest3: Encodable
{
    let action: String
    let amount: OrderAmount3
    //let savedCard: OrdersavedCard?
    //let billingAddress: OrderbillingAddress?
    //let merchantOrderReference: String
    //let emailAddress: String
    let emailAddress: String
    let firstname: String
    let lastname: String
   
    
    private enum  OrderRequestCodingKeys: String, CodingKey {
        case action
        case amount
        //case savedCard
        //case merchantOrderReference
        //case billingAddress
        //case emailAddress
        case emailAddress
        case firstname
        case lastname
    }
}

