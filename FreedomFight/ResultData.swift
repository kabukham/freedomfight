//
//  ResultData.swift
//  FreedomFight
//
//  Created by khaled abukhamireh on 7/26/24.
//

import Foundation
struct ResultData: Decodable{
    let statusCode: Int
    let body: [Event]
}
