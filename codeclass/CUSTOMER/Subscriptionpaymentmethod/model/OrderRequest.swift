//
//  OrderRequest.swift
//  Simple Integration
//
//  Created by Johnny Peter on 23/08/19.
//  Copyright © 2019 Network International. All rights reserved.
//

import Foundation

// This is just a sample order request class
// Check docs for all possible fields available
struct OrderRequest: Encodable
{
    let action: String
    let amount: OrderAmount
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



