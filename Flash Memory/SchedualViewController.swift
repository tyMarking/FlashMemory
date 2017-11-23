//
//  SchedualViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 10/13/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class SchedualViewController: UIViewController {
    @IBOutlet weak var schedualView: UITableView!
    var cardSet = CardSet(name: "nil")
    var terms: [[Int]] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dayCell = schedualView.dequeueReusableCell(withIdentifier: "schedualCell", for: indexPath) as! termCellBothTableViewCell

        return dayCell
        //return cells[indexPath.row]
    }
    @IBAction func newTerm(_ sender: UIButton) {
        //scrollToBottom()
        let termCell = schedualView.dequeueReusableCell(withIdentifier: "termCellBothTableViewCell") as! termCellBothTableViewCell
        termCell.setNum(num: cardSet.getTerms().count)
        let blankTerm = Term(name: "", deffinition: "")
        cardSet.addTerm(term: blankTerm)
        //cells.append(termCell)
        schedualView.reloadData()
        ViewController.saveData()
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<10 {
            terms.append(cardSet.getDaysTerms(day: i))
        }
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ViewController.saveData()
        if (segue.identifier == "InfoFromSchedual") {
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
