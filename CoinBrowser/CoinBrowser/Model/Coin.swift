//
//  Coins.swift
//  CoinBrowser
//
//  Created by Brody Sears on 1/31/22.
//

import Foundation

// ID: string, Symbol: string, name:


class Coin {
    
    var id: String
    var symbol: String
    var name: String
    
    init(id: String, symbol: String, name: String) {
        self.name = name
        self.symbol = symbol
        self.id = id
    }
}
