//
//  Card.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//


import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    var cardColor: Color
    var offset: CGFloat = 0
    var title: String
    var subtitle: String
    var optionalText: String = ""
    var underText: String = ""
    var cardType: CardType = .WithIcon
    var textSize: CGFloat = 140
    var textOffset: CGFloat = 0
    var detail: String = ""
}

enum CardType {
    case JustText
    case WithIcon
}
