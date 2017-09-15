//
//  CardSet.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/15/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import Foundation

class CardSet: NSObject, NSCoding {
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
    
    
    
    func encode(with aCoder: NSCoder) {
        print("Ecoding")
        aCoder.encode(terms, forKey: Keys.Terms)
        print("Encoded terms")
        aCoder.encode(name, forKey: Keys.Name)
        print("Encoded name")
        aCoder.encode(desc, forKey: Keys.Desc)
        print("Encoded all")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let termsObj = aDecoder.decodeObject(forKey: Keys.Terms) as? [Term] {
            terms = termsObj
        }
        if let nameObj = aDecoder.decodeObject(forKey: Keys.Name) as? String {
            name = nameObj
        }
        if let descObj = aDecoder.decodeObject(forKey: Keys.Desc) as? String {
            desc = descObj
        }
    }
    
    
    //MARK: Types
    struct Keys {
        static let Terms = "terms"
        static let Name = "name"
        static let Desc = "desc"
    }
    
}
