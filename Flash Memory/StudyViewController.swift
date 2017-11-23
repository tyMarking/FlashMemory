//
//  StudyViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/15/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {
    var isName = false
    var cardSet: CardSet = CardSet(name: "nil")
    var term: Term = Term(name: "", deffinition: "")
    var termCount = 0
    var currentTermCount = 0
    var isShuffled = false
    var termOrder: [Int] = []
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBAction func ButtonAction(_ sender: UIButton) {
        if (isName) {
            buttonOutlet.setTitle(term.deffinition, for: .normal)
                isName = false
        } else {
            buttonOutlet.setTitle(term.name, for: .normal)
            isName = true
        }
    }
    
    @IBAction func nextTerm(_ sender: UIButton) {
        if termCount == 0 {
            return
        }
        isName = true
        if (isShuffled) {
            currentTermCount = (currentTermCount+1) % termCount
            term = cardSet.getTerms()[termOrder[currentTermCount]]
            updateTerm()
        } else {
            currentTermCount = (currentTermCount+1) % termCount
            term = cardSet.getTerms()[currentTermCount]
            updateTerm()
        }
    }
    @IBAction func shuffle(_ sender: UIButton) {
        if (termCount == 0) {
            return
        }
        if (isShuffled) {
            isShuffled = false
            currentTermCount = 0
            term = cardSet.getTerms()[0]
            updateTerm()
        } else {
            isShuffled = true
            termOrder = []
            for var i in 0..<termCount {
                //just to stop the compiler from telling me to change the dec of i to let
                i = i + 0
                var rand = Int(arc4random_uniform(UInt32(termCount)))
                while (termOrder.contains(rand)) {
                    rand = Int(arc4random_uniform(UInt32(termCount)))
                }
                if (termOrder.count > i) {
                    print("HIIIIIIIIIII")
                    termOrder[i] = rand
                } else {
                    termOrder.append(rand)
                }
            }
            term = cardSet.getTerms()[termOrder[0]]
            currentTermCount = 0
            updateTerm()
        }
    }
    
    func updateTerm() {
        isName = true
        buttonOutlet.setTitle(term.name, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.saveData()
        termCount = cardSet.getTerms().count
        if termCount == 0 {
            term = Term(name: "No Terms", deffinition: "No Terms")
        } else {
            term = cardSet.getTerms()[0]
        }
        buttonOutlet.setTitle(term.name, for: .normal)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ViewController.saveData()
        if (segue.identifier == "InfoFromStudy") {
            let toController = segue.destination as! InfoViewController
            toController.cardSet = cardSet
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
