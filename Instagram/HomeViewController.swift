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

       override func viewDidLoad() {
           super.viewDidLoad()

           tableView.delegate = self
           tableView.dataSource = self

           // カスタムセルを登録する
           let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
           tableView.register(nib, forCellReuseIdentifier: "Cell")
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

