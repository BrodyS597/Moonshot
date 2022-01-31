//
//  CoinsController.swift
//  CoinBrowser
//
//  Created by Brody Sears on 1/31/22.
//

import Foundation

class CoinController {
    
    // MARK: -Source of truth
    static var coins: [Coin] = []
    
    // MARK: -CRUD FUNCS
    
    private static let baseURLString = "https://api.coingecko.com/api/v3"
    private static let keyCoinsComponent = "coins"
    private static let keyListComponent = "list"
    
    
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        guard var baseURL = URL(string: baseURLString) else { return completion(false)}
        
        baseURL.appendPathComponent("coins")
        baseURL.appendPathComponent("list")
        
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { coinData, _, error in
            if let error = error {
                print("There was an error:\(error.localizedDescription)")
                completion(false)
            } else {
                guard let data = coinData else { completion(false); return }
                do {
                    if let topLevelArrayOfCoinDictionaries = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
                        for coinDictionary in topLevelArrayOfCoinDictionaries {
                            if let id = coinDictionary["id"],
                               let symbol = coinDictionary["symbol"],
                               let name = coinDictionary["name"] {
                                let parcedCoin = Coin(id: id, symbol: symbol, name: name)
                                coins.append(parcedCoin)
                            }
                        }
                    }
                    completion(true)
                } catch {
                    completion(false)
                    print("Error in Do/Try/Catch: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    
}//End of class

