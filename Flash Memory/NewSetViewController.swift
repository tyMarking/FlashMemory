//
//  NewSetViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

class NewSetViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    @IBAction func createNewSet(_ sender: UIButton) {
        let set = CardSet(name: nameField.text!, desc: descField.text!)
        sets.append(set)
    }
    
    
    @IBAction func createTestSet(_ sender: UIButton) {
        let set = CardSet(name: "Latin Vocab", desc: "A test set")
        let names = ["1","2","3"]
        let deffs = ["one","two","three"]
        for i in 0 ..< 3 {
            let term = Term(name: names[i], deffinition: deffs[i])
            set.addTerm(term: term)
        }
        sets.append(set)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //UserDefaults.standard.set(data, forKey: "sets")
        print("IT has prepared")
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
