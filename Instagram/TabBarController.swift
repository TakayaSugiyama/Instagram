//
//  TabBarController.swift
//  Instagram
//
//  Created by 杉山貴哉 on 2020/09/11.
//  Copyright © 2020 TakayaSugiyama. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // タブアイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue:0.11, alpha: 1)
        // タブバーの背景色
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        // UITabBarControllerプロトコルのメソッドをこのクラスで処理する
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //タブバーのアイコンがタップされた時に呼ばれるdelegeteメソッドを処理する
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // ImageSelectViewControllerは、タブ切り替えではなくモーダル画面j遷移する
        if viewController is ImageSelectViewController {
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            present(imageSelectViewController, animated: true)
            return false
        }else{
            //その他のViewControllerは通常のタブ切り替えを実施
            return true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
          //ログインしていない時の処理
          let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
          present(loginViewController!, animated: true)
        }
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
