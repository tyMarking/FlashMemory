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
    var dayNum = 0
    var finished: [Int] = []
    var unstudied: [Int] = []
    var boxes: [[[Int]]] = [  [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ], [ [],[],[],[] ]  ]
    var boxesDays = [ [0,2,5,9], [1,3,6,0], [2,4,7,1], [3,5,8,2], [4,6,9,3], [5,7,0,4], [6,8,1,5], [7,9,2,6], [8,0,3,7], [9,1,4,8] ]
    /*
     0: 0-2-5-9
     1: 1-3-6-0
     2: 2-4-7-1
     3: 3-5-8-2
     4: 4-6-9-3
     5: 5-7-0-4
     6: 6-8-1-5
     7: 7-9-2-6
     8: 8-0-3-7
     9: 9-1-4-8
     */
    
    var nextDate = Date.distantPast
    
    init(name: String, desc: String = "No Description") {
        super.init()
        self.name = name
        self.desc = desc
        nextDate = Date(timeInterval: 86400, since: Date())
    }
    
    func addTerm(term: Term) {
        terms.append(term)
        //unstudied.append(terms.count-1)
        boxes[dayNum][0].append(terms.count-1)
    }
    
    public func removeTermAt(index: Int) {
        terms.remove(at: index)
        for i in 0..<boxes.count {
            for j in 0..<boxes[i].count {
                if let boxIndex = boxes[i][j].index(of: index) {
                    boxes[i][j].remove(at: boxIndex)
                }
            }
        }
        if let boxIndex = unstudied.index(of: index) {
            unstudied.remove(at: boxIndex)
        }
        if let boxIndex = finished.index(of: index) {
            finished.remove(at: boxIndex)
        }
    }
    public func termCorrect(index: Int) {
        for i in 0..<boxes.count {
            for j in 0..<boxes[i].count {
                if let boxIndex = boxes[i][j].index(of: index) {
                    boxes[i][j].remove(at: boxIndex)
                    
                    if (j == boxes[i].count-1) {
                        finished.append(index)
                    } else {
                        boxes[i][j+1].append(index)
                    }
                    return
                }
            }
        }
    }
    
    public func termWrong(index: Int) {
        for i in 0..<boxes.count {
            for j in 0..<boxes[i].count {
                if let boxIndex = boxes[i][j].index(of: index) {
                    boxes[i][j].remove(at: boxIndex)
                    print("REMOVED TERM FROM BOX")
                    boxes[(dayNum+1)%9][0].append(index)
                    return
                }
            }
        }
    }
    
    
    public func getTodaysTerms() -> [Int] {
        var retTerms: [Int] = []
        for i in 0..<boxesDays.count {
            for j in 0..<boxesDays[i].count {
                if boxesDays[i][j] == dayNum {
                    print("i: \(i), j: \(j)")
                    if boxes[i][j].count == 0 {
                        print("COUNT IS 0 OF THE BOX")
                    } else {
                        print("COUNT IS NOT 0 OF THE BOX")
                    }
                    for k in 0..<boxes[i][j].count {
                        retTerms.append(boxes[i][j][k])
                    }
                }
            }
        }
        return retTerms
    }
    
    public func getDaysTerms(day: Int) -> [Int] {
        var retTerms: [Int] = []
        for i in 0..<boxesDays.count {
            for j in 0..<boxesDays[i].count {
                if boxesDays[i][j] == day {
                    print("i: \(i), j: \(j)")
                    if boxes[i][j].count == 0 {
                        print("COUNT IS 0 OF THE BOX")
                    } else {
                        print("COUNT IS NOT 0 OF THE BOX")
                    }
                    for k in 0..<boxes[i][j].count {
                        retTerms.append(boxes[i][j][k])
                    }
                }
            }
        }
        return retTerms
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
    
    
    public func checkDate() {
        let date = Date()
        if (date > nextDate) {
            nextDate = Date(timeInterval: 86400, since: date)
            dayNum = (dayNum + 1)%9


            
        }
    }
    
    public func setName(name: String) {
        self.name = name
    }
    
    public func setDesc(desc: String) {
        self.desc = desc
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(terms, forKey: Keys.Terms)
        aCoder.encode(name, forKey: Keys.Name)
        aCoder.encode(desc, forKey: Keys.Desc)
        aCoder.encode(nextDate, forKey: Keys.Date)
        aCoder.encode(boxes, forKey: Keys.Boxes)
        aCoder.encode(dayNum, forKey: Keys.DayNum)
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
        if let dateObj = aDecoder.decodeObject(forKey: Keys.Date) as? Date {
            nextDate = dateObj
        }
        if let boxesObj = aDecoder.decodeObject(forKey: Keys.Boxes) as? [[[Int]]] {
            boxes = boxesObj
        }
        if let dayNumObj = aDecoder.decodeObject(forKey: Keys.DayNum) as? Int {
            dayNum = dayNumObj
        }
    }
    
    
    public func addDay() {
        dayNum = (dayNum + 1)%9
    }
    
    //MARK: Types
    struct Keys {
        static let Terms = "terms"
        static let Name = "name"
        static let Desc = "desc"
        static let Date = "date"
        static let Boxes = "boxes"
        static let DayNum = "dayNum"
    }
    
}
