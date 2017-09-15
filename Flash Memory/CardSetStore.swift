//
//  CardSetStore.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/13/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import Foundation


class CardSetStore: NSObject, NSCoding {
    
    private var _sets: [CardSet] = []
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_sets, forKey: Keys.Sets)
    }
    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        if let setsObj = aDecoder.decodeObject(forKey: Keys.Sets) as? [CardSet] {
            _sets = setsObj
        }
    }
    
    //MARK: Types
    struct Keys {
        static let Sets = "sets"
    }
    
}
