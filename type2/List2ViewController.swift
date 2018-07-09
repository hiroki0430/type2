//
//  List2ViewController.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/07/05.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//

import UIKit

class List2ViewController: UIViewController {
    
    var passedIndex:Memory!
    
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
        
    }
    
    override func viewDidLoad() {
        
        // sqliteファイルを見るためにプリント
        super.viewDidLoad()
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)

        
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
    
    
//    編集ボタンが押された時（表示された内容を変更可能にする）
    
    @IBAction func EditButton(_ sender: UIBarButtonItem) {
        
        Fes.isUserInteractionEnabled = true
        Best.isUserInteractionEnabled = true
        Date.isUserInteractionEnabled = true
        impression.isUserInteractionEnabled = true
        
        Fes.textAlignment = .center
        Best.textAlignment = .center
        Date.textAlignment = .center
        impression.textAlignment = .center
        
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
