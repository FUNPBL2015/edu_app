//
//  BattleViewController.swift
//  Legend_of_N
//
//  Created by Yuto Kumagai on 2015/06/19.
//  Copyright (c) 2015年 NagatamaProject. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet weak var mybattlemap: UIImageView!
    @IBOutlet weak var mybattlecode: UIImageView!
    @IBOutlet weak var mycostlabel: UILabel!
    @IBOutlet weak var mycostimage: UIImageView!
    @IBOutlet weak var mycharacter1: UIImageView!
    
    //プログラミング実行ボタン
    @IBAction func myRunButton(sender: AnyObject) {
        //主人公が初期位置にいるときのみmoveCharacter関数を呼び出す
        if(self.mycharacter1.center == myCharacter1StartPoint){
            self.moveCharacter()
        }
    }

    let myCharacter1StartPoint = CGPoint(x: 215, y: 270)
    let myCharacter1MovePoint = CGPoint(x: 440, y: 270)
    let myCharacter1FinishPoint = CGPoint(x: 440, y: 80)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mybattlemap.image = UIImage(named:"battlemap")
        mybattlecode.image = UIImage(named:"battlecode")
        mycostlabel.text = "コスト"
        mycostlabel.textColor = UIColor.blueColor()
        mycostimage.image = UIImage(named:"cost")
        
        mycharacter1.image = UIImage(named:"myCharacter1")
    }
    
    //主人公を動かす
    func moveCharacter(){
        //関数が呼び出されてから"0.4"秒後に"2.0"秒かけて座標("400","280")に移動する
        UIView.animateWithDuration(2.0,
            delay: 0.4 ,
            options: UIViewAnimationOptions.CurveLinear ,
            animations: {
                self.mycharacter1.center = self.myCharacter1MovePoint
            },
            //上のamimationsが実行し終わったらcompletionが呼び出される
            completion:{ (Bool) -> Void in   //(Bool) -> void in ってなによ 噂によるとクロージャっていうらしい
                //completionの中で別のanimateWithDurationを呼び出す
                //今度は"0.2"秒後に"0.2"秒かけて座標("400","80")に移動する
                UIView.animateWithDuration(2.0,
                delay: 0.2 ,
                options: UIViewAnimationOptions.CurveLinear ,
                animations: {
                self.mycharacter1.center = self.myCharacter1FinishPoint
                },
                completion:nil
                )
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
