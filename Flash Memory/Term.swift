//
//  Term.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class Term: NSObject, NSCoding {
    var name: String = ""
    var deffinition: String = ""
    
    init(name: String, deffinition: String) {
        self.name = name
        self.deffinition = deffinition
    }
    
    public func getName() -> String {
        return name
    }
    public func getDeff() -> String {
        return deffinition
    }
    
    public func setName(name: String) {
        self.name = name
    }
    public func setDeff(deff: String) {
        self.deffinition = deff
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Keys.Name)
        aCoder.encode(deffinition, forKey: Keys.Deff)
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let nameObj = aDecoder.decodeObject(forKey: Keys.Name) as? String {
            name = nameObj
        }
        if let descObj = aDecoder.decodeObject(forKey: Keys.Deff) as? String {
            deffinition = descObj
        }
    }

    
    //MARK: Types
    struct Keys {
        static let Name = "name"
        static let Deff = "deff"
    }
    
}
