//
//  ViewController.swift
//  Instagram
//
//  Created by 杉山貴哉 on 2020/09/11.
//  Copyright © 2020 TakayaSugiyama. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    // 投稿データを格納する配列
       var postArray: [PostData] = []
    //Firestroeのリスナー
    var listener: ListenerRegistration!

   override func viewDidLoad() {
       super.viewDidLoad()

       tableView.delegate = self
       tableView.dataSource = self

       // カスタムセルを登録する
       let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
       tableView.register(nib, forCellReuseIdentifier: "Cell")
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            //ログイン済み
            if listener == nil {
                // listener未登録なら、登録してスナップショットを受信する
                let postsRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
                listener = postsRef.addSnapshotListener(){(querySnapshot, error) in
                    if let error = error {
                        print("DEBUG: snapshotの取得に失敗しました。 \(error)")
                        return
                    }
                    //取得したdocumentをもとにPostDataを作成し、postArrayの配列にする
                    self.postArray = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let postData = PostData(document: document)
                        return postData
                    }
                    // Table Viewの表示を更新する
                    self.tableView.reloadData()
                }
            }
        }else{
          //未ログイン or ログアウト
            if listener != nil {
                //listenr登録住みなら削除してpostArrayをクリアする
                listener.remove()
                listener = nil
                postArray = []
                tableView.reloadData()
            }
        }
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return postArray.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // セルを取得してデータを設定する
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
       cell.setPostData(postArray[indexPath.row])

       return cell
   }

}

