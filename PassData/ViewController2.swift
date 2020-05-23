//
//  ViewController2.swift
//  PassData
//
//  Created by ImarkInfotech on 23/05/20.
//  Copyright © 2020 Dharmendra. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var nameString = String()
    var tabelRow = Int()
    var completionHandler:((String) -> String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        let result = completionHandler?("FUS-ROH-DAH!!!")
        
        print("completionHandler returns... \(result)")
        
        textField.text = result
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func BackBtnAction(_ sender: Any) {
        
        _ = UIStoryboard(name: "Main", bundle: nil)
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        var nameUser = textField.text
        viewController.myRow = tabelRow
        viewController.newCompletionHandler = { text in
            
            print("text = \(text)")
            
            return nameUser!
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
