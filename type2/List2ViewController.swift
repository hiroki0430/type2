//
//  List2ViewController.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/07/05.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//

import UIKit
import CoreData

class List2ViewController: UIViewController
,UIGestureRecognizerDelegate{
    
    var passedIndex:Memory!
    
//    let hoge = CoreDataManager(setEntityName: "Memory", attributeNames: ["best","fes","date","impression","picture","id"])
    
    @IBOutlet var tapgesture: UITapGestureRecognizer!
    @IBOutlet weak var Fes: UITextField!
    @IBOutlet weak var Date: UITextField!
    @IBOutlet weak var Best: UITextField!
    @IBOutlet weak var impression: UITextView!
    @IBOutlet weak var Picture: UIImageView!
    
    
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
//hoge.create(values: ["a","b"])
    }
    
    override func viewDidLoad() {
        
        // sqliteファイルを見るためにプリント
        super.viewDidLoad()
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        tapgesture.delegate = self
        Picture.addGestureRecognizer(tapgesture)
        
        //        print("viewdidloadだよ")
        //        print(passedIndex!)
        
        //            JPGをdocumentフォルダから読み出し
        //        ※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
        //        これはcreateした時の画像をフォルダから読み出してきている。
        readJpgImageInDocument(nameOfImage: passedIndex.picture!)!
        
        
        //        let log = passedIndex!
        //        let mem = passedIndex as! Memory
        
        
        Fes.text = passedIndex.fes
        Best.text = passedIndex.best
        Date.text = passedIndex.date
        impression.text = passedIndex.impression
        Picture.image = readJpgImageInDocument(nameOfImage: passedIndex.picture!)!
        
        
        
        Fes.isUserInteractionEnabled = false
        Best.isUserInteractionEnabled = false
        Date.isUserInteractionEnabled = false
        impression.isUserInteractionEnabled = false
        Fes.textAlignment = .center
        Best.textAlignment = .center
        Date.textAlignment = .center
        impression.textAlignment = .center
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        if sender.state == .recognized {
        print("321")
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView1 = storyboard.instantiateViewController(withIdentifier: "photo2") as! photo2ViewController
        nextView1.image = Picture.image
        present(nextView1, animated: true,completion: nil)
        }
    }
    
   
    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
    
        let alertController = UIAlertController(title: "削除しますか？", message: nil, preferredStyle: .alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "やっぱ止める", style: UIAlertActionStyle .default, handler:{  (action:UIAlertAction) in
            
        })
        
        let deleteAction:UIAlertAction = UIAlertAction(title: "削除", style: UIAlertActionStyle .default, handler:{  (action:UIAlertAction) in
            
            //            coredata削除の処理をかく
            self.deleteMemory(uuid: self.passedIndex.picture!)
//            self.performSegue(withIdentifier: "back", sender: nil)
            
            self.performSegue(withIdentifier: "backBack", sender: self)

})
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController,animated: true,completion: nil)
    }
    

    func deleteMemory(uuid:String){
        
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appdel.persistentContainer.viewContext
        // 読み込むエンティティを指定
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Memory")
        // 更新するデータを指定する。この場合ショップ名が市場のレコード。
        let predict = NSPredicate(format: "picture = %@", uuid)
        fetchReq.predicate = predict
        // データを格納する空の配列を用意
        var results:[Memory] = []
        // 読み込み実行
        do {
            //                results = try managedContext.executeFetchRequest(fetchReq)
            results = try managedContext.fetch(fetchReq) as! [Memory]
            let result = results[0]
            managedContext.delete(result)
        }catch{
            print(error)
        }
        // 保存
        do{
            try managedContext.save()
        }catch{
        }
        
    }
    
}
