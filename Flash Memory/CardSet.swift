//
//  CardSet.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class CardSet: NSObject {
    var terms: [Term] = []
    var name = ""
    var desc = ""
    
    
    init(name: String, desc: String = "No Description") {
        super.init()
        self.name = name
        self.desc = desc
        
    }
    
    func addTerm(term: Term) {
        terms.append(term)
    }
    
    public func removeTermAt(index: Int) {
        terms.remove(at: index)
    }
    
    func getTerms() -> [Term] {
        return terms
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getDesc() -> String {
        return desc
    }
    
    
    
}
