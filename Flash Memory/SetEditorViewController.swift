//
//  SetEditorViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class SetEditorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextField!
    var cardSet = CardSet(name: "nil")
    var cells: [TermCellSplit] = []
    @IBOutlet weak var termTable: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardSet.getTerms().count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let termCell = termTable.dequeueReusableCell(withIdentifier: "termCellSplit", for: indexPath) as! TermCellSplit
        if (indexPath.row < cardSet.getTerms().count) {
            termCell.setName(setName: cardSet.getTerms()[indexPath.row].getName())
            termCell.setDeff(setDeff: cardSet.getTerms()[indexPath.row].getDeff())
            termCell.setNum(num: indexPath.row+1)
        } else {
            termCell.setName(setName: "")
            termCell.setDeff(setDeff: "")
            termCell.setNum(num: indexPath.row)

        }
        termCell.deff.delegate = self
        termCell.name.delegate = self
        return termCell
        //return cells[indexPath.row]
    }
    @IBAction func newTerm(_ sender: UIButton) {
        //scrollToBottom()
        let termCell = termTable.dequeueReusableCell(withIdentifier: "termCellSplit") as! TermCellSplit
        termCell.setNum(num: cardSet.getTerms().count)
        let blankTerm = Term(name: "", deffinition: "")
        termCell.deff.delegate = self
        termCell.name.delegate = self
        cardSet.addTerm(term: blankTerm)
        //cells.append(termCell)
        termTable.reloadData()
        ViewController.saveData()

    }
    
    func scrollToBottom(){
        /*DispatchQueue.global(qos: .background).async {
            let indexPath = IndexPath(row: self.cardSet.getTerms().count-1, section: 0)
            termTable.tblComment.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }*/
        let pointsFromTop = CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude)
        termTable.setContentOffset(pointsFromTop, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ViewController.saveData()

        //update card set
        /*if (cardSet.getTerms().count > cells.count) {
            for i in cells.count+1 ... cardSet.getTerms().count {
                cardSet.removeTermAt(index: i-1)
            }
        }
        for i in 0 ..< cells.count {
            if (cardSet.getTerms().count < i+1) {
                let term = Term(name: cells[i].name.text!, deffinition: cells[i].deff.text!)
                cardSet.addTerm(term: term)
            } else {
                cardSet.getTerms()[i].setName(name: cells[i].name.text!)
                cardSet.getTerms()[i].setDeff(deff: cells[i].deff.text!)
            }
        }*/
        
        //pass set
        //UserDefaults.standard.set(sets, forKey: "sets")
        if (segue.identifier == "InfoFromEditor") {
            let toController = segue.destination as! InfoViewController
            toController.cardSet = cardSet

        }
        if nameField.text! != "" {
           cardSet.setName(name: nameField.text!)
        }
        if descField.text! != "" {
            cardSet.setDesc(desc: descField.text!)
        }
        
        
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            cardSet.removeTermAt(index: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0 ..< cardSet.getTerms().count {
            let termCell = termTable.dequeueReusableCell(withIdentifier: "termCellSplit") as! TermCellSplit
            termCell.setName(setName: cardSet.getTerms()[i].getName())
            termCell.setDeff(setDeff: cardSet.getTerms()[i].getDeff())
            termCell.setNum(num: i+1)
            cells.append(termCell)
            termCell.deff.delegate = self
            termCell.name.delegate = self
        }
        print("LOOK AT ME")
        print(cardSet.getName())
        nameField.text = cardSet.getName()
        descField.text = cardSet.getDesc()
        nameField.delegate = self
        descField.delegate = self
        ViewController.saveData()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("SO THIS DID WORK")
        for i in 0 ..< cardSet.getTerms().count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = termTable.cellForRow(at: indexPath) as! TermCellSplit
            cardSet.getTerms()[i].setName(name: cell.name.text!)
            cardSet.getTerms()[i].setDeff(deff: cell.deff.text!)
        }
    }

    /*func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        code
    }*/
    
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
