//
//  FiestViewController.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/06/21.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//

import UIKit
import CoreData

class FiestViewController: UIViewController {
    
    let picker = UIDatePicker()
    
    @IBOutlet weak var textFild: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        ここには見えない＝が入ってると思え！(ex)best = "321"
        createMemory(fes: textFild.text!,best: "321", date: textField2.text!)
        
        readMemory()
        createDatePicker()
        
    }
    
    
    //    日付のtextFieldが押されたら、datePickerをだす
    
    func createDatePicker(){
        
        //        toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //        done button for toolbar
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        textField2.inputAccessoryView = toolbar
        textField2.inputView = picker
        
        //        format picker for date
        picker.datePickerMode = .date
        
    }
    
    @objc func donePressed(){
        //        format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        
        textField2.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    //    ここまで↑が日付の処理
   
    
//コアデータにInsert into
    func createMemory(fes:String, best:String, date:String){
        
        print(fes)
        print(best)
        print(date)

        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

        let manageContext = appDelegate.persistentContainer.viewContext

        let Memory = NSEntityDescription.entity(forEntityName: "Memory", in:manageContext)

        // contextに１レコード追加
        let newRecord = NSManagedObject(entity: Memory!, insertInto: manageContext)

        // レコードに値の設定
        newRecord.setValue(fes, forKey: "fes")
        newRecord.setValue(date, forKey: "date")
        newRecord.setValue(best, forKey: "best")


        do {
            try manageContext.save()  // throw はdocatchとセットで使う
        } catch  {
            // errorが出たらこちらに来る
            print("error:",error)

        }

    }
    
//    コアデータ呼び出し
    func readMemory() {
        // Read処理
        // AppDelegateのインスタンス化
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        // フェッチして取り出し（リクエストの準備）
        let fetchRequest:NSFetchRequest<Memory> = Memory.fetchRequest()
        
        // 絞り込み
        //        let predicate = NSPredicate(format: "place = %@", "Cebu")
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
                
                print("fes:\(fes)","date:\(date)")
            }
        } catch  {
            print("read error:",error)
        }
        
        
        
    }
    
    
    

}
