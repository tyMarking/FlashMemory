//
//  ViewController.swift
//  Flash Memory
//
//  Created by Ty Marking on 9/3/17.
//  Copyright © 2017 Ty Markijg. All rights reserved.
//

import UIKit

var sets: [CardSet] = []
var myIndex = 0
var launched = false

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("Data").path
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = sets[indexPath.row].getName()
        
        return cell 
    }
    
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            sets.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        print("The index is: \(myIndex)")
        performSegue(withIdentifier: "segueToInfo", sender: self)
    }
    
    
    override func prepare(for segueToInfo: UIStoryboardSegue, sender: Any?) {
        if (segueToInfo.identifier == "segueToInfo") {
            let toController = segueToInfo.destination as! InfoViewController
            toController.cardSet = sets[myIndex]
        }
        saveData()
        print("SO IT IS")

    }
    
    private func saveData() {
        print("len of sets: \(sets.count)")
        NSKeyedArchiver.archiveRootObject(sets, toFile: filePath)
    }
    
    /*func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(sets, forKey: "sets")
        print("WIll CLOSE NOW")
    }*/
    
    private func loadData() {
        if let inData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [CardSet] {
            sets = inData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        // Do any additional setup after loading the view, typically from a nib.
        if (launched == false) {
            print("Loading data")
            //first launch
            loadData()
            launched = true
        }
        print("Will save Data")
        saveData()
        print("Saved Data")
        tableView.reloadData()
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

