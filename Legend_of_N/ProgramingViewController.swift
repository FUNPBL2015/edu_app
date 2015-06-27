//
//  ProgramingViewController.swift
//  Legend_of_N
//
//  Created by Yuto Kumagai on 2015/06/19.
//  Copyright (c) 2015年 NagatamaProject. All rights reserved.
//

import UIKit

class ProgramingViewController: UIViewController {
    @IBOutlet weak var myProgrammingCodeBackground: UIImageView!
    @IBOutlet weak var mycostLabel: UILabel!
    @IBOutlet weak var mycostImage: UIImageView!
    //プログラミング画面が閉じて戦闘画面へと戻るボタン
    @IBOutlet weak var SourceButtonScrollView: UIScrollView!
    @IBAction func myBackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true,completion:nil)
    }
    
    var SourceButtons = Dictionary<String, UIButton>()
    
    
    private func createSourceButton(image: String, tag: Int) -> UIButton{
        let button = UIButton()
        button.setImage(UIImage(named:image), forState: UIControlState.Normal)
        button.frame.size = CGSizeMake(38,38)
        button.layer.position = CGPoint(x: 19, y:500)
        button.tag = tag
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.SourceButtonScrollView.contentSize = CGSizeMake(240, 700);
        
        SourceButtons["0"] = self.createSourceButton("SourceButton_0", tag: 1)
        self.SourceButtonScrollView.addSubview(SourceButtons["0"]!)
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
