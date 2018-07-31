//
//  FiestViewController.swift
//  type2
//
//  Created by 三井 裕貴 on 2018/06/21.
//  Copyright © 2018年 三井 裕貴. All rights reserved.
//

import UIKit
import CoreData

class FiestViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIDatePicker()
    
    @IBOutlet weak var textFild: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var picture1: UIImageView!
    @IBOutlet weak var textView1: UITextView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        readMemory()
        createDatePicker()
        Image.image = UIImage(named: "icon.png")
        textFild.placeholder = "どのフェスに行ったの？"
        textField2.placeholder = "いつ行ったの？"
        textField3.placeholder = "ベストアクトを教えてよ！"
        
        
    }
    
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
//    日付のtextFieldが押されたら、datePickerをだす
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
    
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
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
  
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
//    登録ボタンが押されたらコアデータを登録する処理。
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
    
    @IBAction func Reg(_ sender: Any) {
        
//        ※まじ重要※ ここには見えない＝が入ってると思え！(ex)best = "321"
        createMemory(fes: textFild.text!,best: textField3.text!, date: textField2.text!, impression: textView1.text!, picture: picture1.image!)
        
        
        let alertButton = UIAlertController(title: "登録完了しました。", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let OkButton = UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self.performSegue(withIdentifier: "List", sender: nil)
            })
            
            })
        
        alertButton.addAction(OkButton)
        present(alertButton, animated: true, completion: nil)

        
        
//        let storyboard: UIStoryboard = self.storyboard!
//        let nextView = storyboard.instantiateViewController(withIdentifier: "Done") as! DoneViewController
//        self.present(nextView, animated: true, completion: nil)
//
    }
    
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
    
    
//    ※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
//    JPGをDocumentsフォルダへ保存
//    ※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
    
    func storeJpgImageInDocument(image: UIImage , name: String) {
        let documentDirectory =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) // [String]型
        let dataUrl = URL.init(fileURLWithPath: documentDirectory[0], isDirectory: true) //URL型 Documentpath
        
        let dataPath = dataUrl.appendingPathComponent(name)
        //URL型 documentへのパス + ファイル名
        
        // UIImageJPEGRepresentationの後ろは1が最大のクオリティ
        // https://qiita.com/marty-suzuki/items/159b1c5d47fb00c11fda
        let myData = UIImageJPEGRepresentation(image, 1.0)! as NSData // Data?型　→ NSData型
        
        myData.write(toFile: dataPath.path , atomically: true) // NSData型の変数.write(String型,Bool型)
        
    }
    
// ※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
    
// ※※※※※※※※※※※※※※※※※※※※※※※※※※
//   コアデータにInsert into
// ※※※※※※※※※※※※※※※※※※※※※※※※※※

    func createMemory(fes:String, best:String, date:String, impression:String, picture:UIImage){
        
         let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
         let manageContext = appDelegate.persistentContainer.viewContext
        
        print(fes)
        print(best)
        print(date)
        print(impression)
        print(picture)
        

       
        do {
            try manageContext.save()
            // throw はdocatchとセットで使う
        } catch  {
            // errorが出たらこちらに来る
            print("error:",error)

        }

        readMemory()

    }
// ※※※※※※※※※※※※※※※※※※※※※
//    コアデータ呼び出し
// ※※※※※※※※※※※※※※※※※※※※※
    
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
  
    
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
//    JPGをdocumentフォルダから読み出し
//※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※
    
    
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

//    カメラ
    
    @IBOutlet weak var Image: UIImageView!
    
    @IBAction func choose(_ sender: UIButton) {
        
        // カメラロールが利用可能か？
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる
            pickerView.sourceType = .photoLibrary
            // デリゲート
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
        
    }
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // ビューに表示する
        self.Image.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
    
    @IBAction func rewrite(_ sender: UIButton) {
        
            // アラートで確認
            let alert = UIAlertController(title: "確認", message: "画像を初期化してもよいですか？", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler:{(action: UIAlertAction) -> Void in
                // デフォルトの画像を表示する
                self.Image.image = UIImage(named: "default.png")
            })
            let cancelButton = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            // アラートにボタン追加
            alert.addAction(okButton)
            alert.addAction(cancelButton)
            // アラート表示
            present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func tapImage(_ sender: UITapGestureRecognizer) {
//        print("eee")
        
//        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
//            let picker = UIImagePickerController()
//            picker.sourceType = .photoLibrary
//            picker.delegate = self
//            self.present(picker, animated: true, completion: nil)
//        }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "Photo") as! PhotoViewController
        
        nextView.image = Image.image
        present(nextView, animated: true, completion: nil)
    }
    
//    func ImagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextView = storyboard.instantiateViewController(withIdentifier: "Photo") as! PhotoViewController
//
//        nextView.image = image
//
//        self.dismiss(animated: false)
//        present(nextView, animated: true, completion: nil)
//    }
    

}
