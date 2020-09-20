//
//  CommntViewController.swift
//  Instagram
//
//  Created by 杉山貴哉 on 2020/09/18.
//  Copyright © 2020 TakayaSugiyama. All rights reserved.
//

import UIKit
import Firebase

class CommntViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var originalComment: UILabel!
    var postData: PostData!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        self.commentTextField.delegate = self
    }
    

    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let db = Firestore.firestore()
        print("DEBUG_PRINT: コメントが入力されました. \(textField.text!)")
        // firestoreに保存する
        var updateValue: FieldValue
        updateValue = FieldValue.arrayUnion(["\(self.postData.name!): " + "\(commentTextField.text!)"])
        let postRef = db.collection(Const.PostPath).document(self.postData.id)
        postRef.updateData(["comments": updateValue])
        self.dismiss(animated: true, completion: nil)
        return true
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
