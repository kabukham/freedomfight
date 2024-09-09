//
//  Events.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 7/17/24.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct EventKey:Decodable, Encodable, Equatable{
    var PK: String
    var SK: String
    init()
    {
        PK = ""
        SK = ""
    }
    static func == (lhs: EventKey, rhs: EventKey) -> Bool {
        return lhs.PK == rhs.PK && lhs.SK == rhs.SK
    }
}

struct Event: Decodable, Identifiable{
    
    let PK: String
    let SK: String
    let id: UUID
    let name: String
    let description: String
    let eventDateTime: String
    let address: Address
    let sponsors: [String]
    let link: String
    let image: String
    
    
    struct Address:Decodable, Identifiable
    {
        let id: UUID
        let address1: String
        let address2: String
        let city: String
        let state: String
        let zipCode: String
        let county: String
        var fullAddress: String {
            get {
                var fAddress = ""
                if address2.isEmpty{
                    fAddress = "\(address1), \(city), \(state), \(zipCode)"
                }
                else{
                    fAddress = "\(address1), \(address2), \(city), \(state), \(zipCode)"
                }
                return fAddress
            }
        }
        
        init()
        {
            id = UUID.init()
            address1 = ""
            address2 = ""
            city = ""
            state = ""
            zipCode = ""
            county = ""
        }
    }
    init() {
        self.PK = ""
        self.SK = ""
        self.id = UUID.init()
        self.name = ""
        self.description = ""
        self.eventDateTime = ""
        self.address = Address()
        self.sponsors = [""]
        self.link = ""
        self.image = ""
    }
}
