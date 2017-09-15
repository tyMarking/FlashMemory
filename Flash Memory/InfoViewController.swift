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
    
    @IBOutlet weak var termTable: UITableView!
    
    /*override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }*/
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("SUP people")
        return cardSet.getTerms().count
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let termCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "termCell")
        termCell.textLabel?.text = cardSet.getTerms()[indexPath.row].getName()
        return termCell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //UserDefaults.standard.set(sets, forKey: "sets")
        if (segue.identifier == "segueToEdit") {
            let toController = segue.destination as! SetEditorViewController
            toController.cardSet = cardSet
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
