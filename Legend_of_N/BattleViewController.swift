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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mybattlemap.image = UIImage(named:"battlemap")
        mybattlecode.image = UIImage(named:"battlecode")
        mycostlabel.text = "コスト"
        mycostlabel.textColor = UIColor.blueColor()
        mycostimage.image = UIImage(named:"cost")
        
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
