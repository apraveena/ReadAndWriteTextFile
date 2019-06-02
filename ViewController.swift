//
//  ViewController.swift
//  ReadAndWriteToTextFile
//
//  Created by Spur IQ on 5/26/19.
//  Copyright © 2019 Praveena. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allToys = ["Basket Ball", "Rubik's cube", "Darts", "Exploding Kittens", "Breakable Erasers"]
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    let fileName = "toys"
    let fileExt = "txt"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allToys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.textLabel?.text = allToys[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        readFromExistingFile()
        myTableView.reloadData()
    }
    
    @IBAction func SaveToArrayButton(_ sender: Any) {
        if(input.text != "") {
            allToys.append(input.text!)
            writeDataToTextFile()
            readFromExistingFile()
            myTableView.reloadData()
            input.text = ""
        }
        
    }
    
    func readFromExistingFile(){
        if let toysURL = Bundle.main.url(forResource: fileName, withExtension: fileExt) {
            print("Toys URL", toysURL)
            if let toyString = try? String(contentsOf: toysURL) {
                allToys = toyString.components(separatedBy: "\n")
                print("All toys loaded")
                print(allToys)
            }
        }
        
        if allToys.isEmpty {
            allToys = ["Silly Putty"]
        }
      
    }
    
    func writeDataToTextFile(){
        if let toysURL = Bundle.main.url(forResource: fileName, withExtension: fileExt){
            (allToys as NSArray).write(to: toysURL, atomically: true)
            let allToysStr = allToys.joined(separator: "\n")
            do {
                try allToysStr.write(to:toysURL, atomically:true, encoding: String.Encoding.utf8)
                readFromExistingFile()
            } catch let error as NSError {
                print ("Error occured during write", error)
            }
        }
    }
}

