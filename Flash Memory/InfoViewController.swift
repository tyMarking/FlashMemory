//
//  InfoViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var cardSet = CardSet(name: "nil")
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var testOutlet: UILabel!
    @IBOutlet weak var termTable: UITableView!
    
    /*override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }*/
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardSet.getTerms().count
        
    }
    
    
    /*public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let termCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "termCell")
        termCell.textLabel?.text = cardSet.getTerms()[indexPath.row].getName()
        return termCell
    }*/
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let termCell = termTable.dequeueReusableCell(withIdentifier: "termCellBothTableViewCell", for: indexPath) as! termCellBothTableViewCell
        if (indexPath.row < cardSet.getTerms().count) {
            termCell.setName(setName: cardSet.getTerms()[indexPath.row].getName())
            termCell.setDeff(setDeff: cardSet.getTerms()[indexPath.row].getDeff())
            termCell.setNum(num: indexPath.row+1)
        } else {
            termCell.setName(setName: "")
            termCell.setDeff(setDeff: "")
            termCell.setNum(num: indexPath.row)
            
        }
        return termCell
        //return cells[indexPath.row]
    }
    @IBAction func newTerm(_ sender: UIButton) {
        //scrollToBottom()
        let termCell = termTable.dequeueReusableCell(withIdentifier: "termCellBothTableViewCell") as! termCellBothTableViewCell
        termCell.setNum(num: cardSet.getTerms().count)
        let blankTerm = Term(name: "", deffinition: "")
        cardSet.addTerm(term: blankTerm)
        //cells.append(termCell)
        termTable.reloadData()
        ViewController.saveData()
        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ViewController.saveData()
        //UserDefaults.standard.set(sets, forKey: "sets")
        ViewController.saveData()
        if (segue.identifier == "segueToEdit") {
            let toController = segue.destination as! SetEditorViewController
            toController.cardSet = cardSet
        }
        
        if (segue.identifier == "StudyFromInfo") {
            let toController = segue.destination as! StudyViewController
            toController.cardSet = cardSet
        }
        
        if (segue.identifier == "SRSFromInfo") {
            let toController = segue.destination as! SRStudyViewController
            toController.cardSet = cardSet
        }
        
        if (segue.identifier == "SchedualFromInfo") {
            let toController = segue.destination as! SchedualViewController
            toController.cardSet = cardSet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.saveData()

        // Do any additional setup after loading the view.
        nameLabel.text = cardSet.getName()
        descLabel.text = cardSet.getDesc()
        self.termTable.reloadData()
        
        print("name of set passed: \(cardSet.getName())")
        
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
    @IBAction func addDay(_ sender: UIButton) {
        cardSet.addDay()
    }

}
