//
//  PeopleHelp.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/26/21.
//

import Foundation

struct PeopleHelp : Decodable, Identifiable {
    var id: Int
    let name: String
    let website: String
    let descr: String
}
