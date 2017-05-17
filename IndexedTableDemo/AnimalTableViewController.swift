//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Logan on 2017/5/15.
//  Copyright © 2017年 com.Logan. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    func createAnimalDict() {
        for animal in animals {
            let animalKey = animal.substring(to: animal.characters.index(animal.startIndex, offsetBy: 1))
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
        }
        animalSectionTitles = [String](animalsDict.keys)    //  取得字典的Key
        animalSectionTitles = animalSectionTitles.sorted{ $0 < $1 } //因回傳的key未做排序
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //產生動物字典
        createAnimalDict()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        //return 1
        return animalSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        //return animals.count
        //回傳區塊的列數
        let animalKey = animalSectionTitles[section]
        if let animalValues = animalsDict[animalKey] {
            return animalValues.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 

        let animalKey = animalSectionTitles[indexPath.section]
        if let animalValues = animalsDict[animalKey] {
            // Configure the cell...
            cell.textLabel?.text = animalValues[indexPath.row]
            
            // Convert the animal name to lower case and
            // then replace all occurences of a space with an underscore
            let imageFilename = animalValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_", options: [], range: nil)
            cell.imageView?.image = UIImage(named: imageFilename)
        }
        
        return cell
    }
    
    //要顯示每個區塊的表頭(header)標題，需要實作titleForHeaderInSection方法
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
    
    //在表格視圖加入索引列表
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return animalIndexTitles
    }
    
    //解決索引數量大於區塊數量，並清楚告訴表格視圖特定索引按下去後的區塊數
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        guard let index = animalSectionTitles.index(of: title) else {
            return -1
        }
        
        return index
    }
    
    //變更區塊標題高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    //在區塊標題視圖顯示前，willDisplayHeaderView方法會被呼叫．這個方法包含一個view參數．這個視圖物件可以是自訂的標題視圖或標準樣式，在這裡只使用標準標題視圖，也就是UITableViewHeaderFooterView物件．
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.orange
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }

}
