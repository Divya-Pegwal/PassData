//
//  ViewController.swift
//  PassData
//
//  Created by ImarkInfotech on 23/05/20.
//  Copyright © 2020 Dharmendra. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var nameArr = ["Virat","Sachin","Rahul","Ravi"]
    var imageArr = [UIImage(named: "flower"),UIImage(named: "Pen"),UIImage(named: "pianoo"),UIImage(named: "Tree")]
    var myRow = Int()
    var newCompletionHandler:((String) -> String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        myTableView.delegate = self
        myTableView.dataSource = self
        self.myTableView.estimatedRowHeight = 286
        self.myTableView.rowHeight = UITableView.automaticDimension
        myTableView.tableFooterView = UIView()
        let result = newCompletionHandler?("FUS-ROH-DAH!!!")
        if result != nil{
            print("completionHandler returns... \(result)")
            nameArr[myRow] = result!
            myTableView.delegate = self
            myTableView.dataSource = self
            myTableView.reloadData()
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = nameArr[indexPath.row]
        
        if let image = imageArr[indexPath.row] as? UIImage {
            if indexPath.row != 0 {
                cell.collectionView.isHidden = false
                cell.collectionViewHeight.constant = 100
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.tag = indexPath.row
                DispatchQueue.main.async {
                    cell.collectionView.reloadData()
                }
                
                
            }else{
                cell.collectionView.isHidden = true
                cell.collectionViewHeight.constant = 0
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = UIStoryboard(name: "Main", bundle: nil)
        let viewController =  self.storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        var nameUser = nameArr[indexPath.row]
        viewController.tabelRow = indexPath.row
        viewController.completionHandler = { text in
            
            print("text = \(text)")
            
            return nameUser
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

class TableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
}

class CollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}


//MARK:-Collection View Method
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = imageArr[collectionView.tag]
        cell.imageView.contentMode = .scaleToFill
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 80)
    }
}
