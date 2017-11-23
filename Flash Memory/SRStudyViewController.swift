//
//  SRStudyViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/21/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class SRStudyViewController: UIViewController {
    var isName = false
    var cardSet: CardSet = CardSet(name: "nil")
    var term: Term = Term(name: "", deffinition: "")
    var termCount = 0
    var orderPos = 0
    var isShuffled = false
    var termOrder: [Int] = []

   
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if (isName) {
            buttonOutlet.setTitle(term.deffinition, for: .normal)
            isName = false
        } else {
            buttonOutlet.setTitle(term.name, for: .normal)
            isName = true
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        if termCount == 0 {
            return
        }
        //necessary??
        updateCurrentTerm()
        isName = true
        orderPos = (orderPos + 1) % termCount
        updateCurrentTerm()
    }
    @IBAction func shuffle(_ sender: UIButton) {
        
        if (termCount == 0) {
            return
        }
        if isShuffled {
            isShuffled = false
            termOrder = []
            for termPos in cardSet.getTodaysTerms() {
                termOrder.append(termPos)
            }
        } else {
            isShuffled = true
            termOrder = []
            for _ in 0..<termCount {
                var rand = cardSet.getTodaysTerms()[Int(arc4random_uniform(UInt32(termCount)))]
                while (termOrder.contains(rand)) {
                    rand = cardSet.getTodaysTerms()[Int(arc4random_uniform(UInt32(termCount)))]
                }
                termOrder.append(rand)
            }
        }
        updateCurrentTerm()
    }
    
    func removeTermFromOrder(pos: Int) {
        for i in pos..<termOrder.count-1 {
            termOrder[i] = termOrder[i+1]
        }
        termOrder.remove(at: termOrder.count-1)
        if orderPos >= termOrder.count {
            orderPos = termOrder.count - 1
        }
    }
    
    @IBAction func incorrect(_ sender: UIButton) {
        if termCount == 0 {
            return
        }
        cardSet.termWrong(index: termOrder[orderPos])
        removeTermFromOrder(pos: orderPos)
        isName = true
        updateCurrentTerm()
        ViewController.saveData()
        print("HEEEEEELLLLOOOOO THERE")
    }
    
    @IBAction func correct(_ sender: UIButton) {
        if termCount == 0 {
            return
        }
        cardSet.termCorrect(index: termOrder[orderPos])
        removeTermFromOrder(pos: orderPos)
        isName = true
        updateCurrentTerm()
        ViewController.saveData()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        termCount = cardSet.getTodaysTerms().count
        if termCount == 0 {
            term = Term(name: "No Terms", deffinition: "No Terms")
        } else {
            termOrder = []
            isShuffled = false
            for termPos in cardSet.getTodaysTerms() {
                termOrder.append(termPos)
            }
            orderPos = 0
            updateCurrentTerm()
        }
        buttonOutlet.setTitle(term.name, for: .normal)
        ViewController.saveData()

        //buttonOutlet.setTitle(term.deffinition, for: .normal)
    }
    
    func updateCurrentTerm() {
        termCount = cardSet.getTodaysTerms().count
        print("TermCount: \(termCount)")
        for i in cardSet.getTodaysTerms() {
            print("Term: \(cardSet.getTerms()[i].getName())")
        }
        if (termCount == 0) {
            term = Term(name: "No Terms", deffinition: "No Terms")
        } else {
            orderPos = orderPos % termCount
            //term = cardSet.getTerms()[cardSet.getTodaysTerms()[termOrder[orderPos]]]
            term = cardSet.getTerms()[termOrder[orderPos]]
        }
        if (isName) {
            buttonOutlet.setTitle(term.name, for: .normal)
        } else {
            buttonOutlet.setTitle(term.deffinition, for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ViewController.saveData()

        if (segue.identifier == "InfoFromSRS") {
            let toController = segue.destination as! InfoViewController
            toController.cardSet = cardSet
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
