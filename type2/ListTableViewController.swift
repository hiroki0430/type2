//
//  ListTableViewController.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/07/04.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//

import UIKit
import CoreData



class ListTableViewController: UITableViewController {
    
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func readJpgImageInDocument(nameOfImage: String) -> UIImage? {
        let documentDirectory =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) // [String]型
        
        let dataUrl = URL.init(fileURLWithPath: documentDirectory[0], isDirectory: true)  //URL型 Documentpath
        let dataPath = dataUrl.appendingPathComponent(nameOfImage)
        
        do {
            
            let myData = try Data(contentsOf: dataPath, options: [])
            let image =  UIImage.init(data: myData)
            
            return image
            
        }catch {
            print(error)
            return nil
        }
        
    }
    
    var getMemory: [Memory] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memory")
        do {
            getMemory = try managedContext.fetch(fetchRequest) as! [Memory]
//            refreshTableView()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func refreshTableView(){
        myTableView.reloadData()
    }
    

//    createしたデータは配列にいれ、フェッチして出す。
    
    
    func readMemory() {
        // Read処理
        // AppDelegateのインスタンス化
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // フェッチして取り出し（リクエストの準備）
        let fetchRequest:NSFetchRequest<Memory> = Memory.fetchRequest()
        
        // 絞り込み
//                let predicate = NSPredicate(format: "date = %@")
        //        fetchRequest.predicate = predicate
        
        // 並び替え
        let sortDescripter = NSSortDescriptor(key: "date", ascending: false) // true:昇順　false 降順
        
        fetchRequest.sortDescriptors = [sortDescripter]
        
        do {
            
            // データ取得 配列で取得される
            let fetchResults = try manageContext.fetch(fetchRequest)
            
            for result in fetchResults {
                // １件ずつ取り出し
                let fes:String? = result.value(forKey: "fes") as? String
                let date = result.value(forKey: "date") as? String
                let best = result.value(forKey: "best") as? String
                let impression = result.value(forKey: "impression") as? String
                let pictureId = result.value(forKey: "picture") as? String
                let picture:UIImage = readJpgImageInDocument(nameOfImage: pictureId!)!
                print("fes:\(fes)","date:\(date)","best:\(best)","impression:\(impression)","picture:\(picture)", "pictureId:\(pictureId)")
            }
        } catch  {
            print("read error:",error)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return getMemory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSaveDate", for: indexPath)
        let Feslog = getMemory[indexPath.row]
        
        // Configure the cell...
        
        readMemory()
        
        cell.textLabel?.text = "\(Feslog.date!)"

        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        
        
        
        
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
