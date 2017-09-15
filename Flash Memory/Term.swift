//
//  Term.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class Term: NSObject {
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
    
}
