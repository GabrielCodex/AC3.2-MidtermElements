//
//  Elements.swift
//  AC3.2-MidtermElements
//
//  Created by John Gabriel Breshears on 12/8/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

class Element {
    let symbol: String
    let number: Int
    let weight: Double
    let melting: Int
    let boiling: Int
    let name: String
    let fullImage: String
    let thumbNailImage: String
    
    init(symbol: String, number: Int, weight: Double, melting: Int, boiling: Int, name: String, fullImage: String, thumbNailImage: String) {
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.melting = melting
        self.boiling = boiling
        self.name = name
        self.fullImage = fullImage
        self.thumbNailImage = thumbNailImage
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let castedSymbol = dictionary["symbol"] as? String,
        let castedNumber = dictionary["number"] as? Int,
        let castedWeight = dictionary["weight"] as? Double,
        let castedMelting = dictionary["melting_c"] as? Int,
        let castedBoiling = dictionary["boiling_c"] as? Int,
            let castedName = dictionary["name"] as? String else {return nil}
        
        let fullImageurl = "https://s3.amazonaws.com/ac3.2-elements/\(castedSymbol).png"
        let thumbNailImageUrl = "https://s3.amazonaws.com/ac3.2-elements/\(castedSymbol)_200.png"
        self.init(symbol: castedSymbol, number: castedNumber, weight: castedWeight, melting: castedMelting, boiling: castedBoiling, name: castedName, fullImage: fullImageurl, thumbNailImage: thumbNailImageUrl)
    }
    
    static func buildElementsArray(from data: Data) -> [Element]? {
        var elementArray: [Element] = []
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
           // Remember Gabriel you are returning nil because if the Json is not an array of dictionary then my parasing won't do shit for it so I don't want it
            guard let jsonArrayDictionary = jsonData as? [[String : Any]] else {return nil}
            
            for dictionary in jsonArrayDictionary {
                guard let elementDictionary = Element(dictionary: dictionary) else {continue}
                // I continue here because if I get a dictionary that doesn't meet my model then I want the function to keep running and build an elementArray
                elementArray.append(elementDictionary)
            }
            
        } catch {
            print("problem parsing json: \(error)")
        }
        return elementArray
    }// end of func
}
