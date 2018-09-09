//
//  CommentViewController.swift
//  Instagram
//
//  Created by ICHIRO KAWATA on 2018/09/10.
//  Copyright © 2018年 ICHIRO KAWATA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {

    var postData: PostData!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func commentButton(_ sender: Any) {
        if let comment = commentTextField.text {
            if comment.isEmpty{
                SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
                return
            }
            // 辞書を作成してFirebaseに保存する
            let username = Auth.auth().currentUser?.displayName
            self.postData.comments.append("\(username!) : \(comment)")
            
            let postRef = Database.database().reference().child(Const.PostPath).child(self.postData.id!)
            let comments = ["comments": postData.comments]
            postRef.updateChildValues(comments)
            
            // HUDでコメント完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントしました")
            // 画面を閉じる
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.postData = appDelegate.postData
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
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
