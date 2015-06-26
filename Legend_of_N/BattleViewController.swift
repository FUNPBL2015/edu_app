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
    func moveView(){
        //関数が呼び出されてから"0.4"秒後に"0.2"秒かけて座標("100","100")に移動する
        UIView.animateWithDuration(0.2,
            delay: 0.4 ,
            options: UIViewAnimationOptions.CurveLinear ,
            animations: {
                self.mycharacter1.center = CGPoint(x: 100,y: 100)
            },
            completion:{ finished  in
                self.mycharacter1.center = CGPoint(x: 0,y: 0)
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
