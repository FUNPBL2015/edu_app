//
//  ProgramingViewController.swift
//  Legend_of_N
//
//  Created by Yuto Kumagai on 2015/06/19.
//  Copyright (c) 2015年 NagatamaProject. All rights reserved.
//

import UIKit

class ProgramingViewController: UIViewController {
    @IBOutlet weak var mycostLabel: UILabel!
    @IBOutlet weak var SourceButtonScrollView: UIScrollView!
    @IBAction func myBackButton(sender: AnyObject) {     //プログラミング画面が閉じて戦闘画面へと戻るボタン
        self.dismissViewControllerAnimated(true,completion:nil)
    }
    @IBOutlet weak var myCodeText: UITextView!
    @IBOutlet weak var myErrorText: UITextView!
    @IBOutlet weak var CostLabel: UILabel!  //コストを表示するラベル
    @IBOutlet weak var SourceCostFrame: UILabel! //ソースコストの枠線 SpriteKit使わないとrect書けないらしい
    
    //ソースコストのゲージ SpriteKit使わないとrect書けないらしいのでラベルでやります
    let SourceCostBar: UILabel = UILabel()

    var canPutResetMethodFlag = true //コードの初期状態と終了状態を表すフラグ
    var canPutActionMethodFlag = false //アクションに関するフラグ
    var canPutArrowMethodFlag = false //矢印に関するフラグ
    var canPutNumberMethodFlag = false //数に関するフラグ
    
    var SourceCostNow = 0  //現在のソースコストの値
    var SourceCostLimit = 15 //現在のソースコストの上限値、将来的にはここが他クラスから変更できるように改変するのかね
    var SourceCostBarFor1Scale : Float = 0.0 //ソースゲージ１目盛り分の長さ
    
    //ソースボタンのDictionary、キー値としてソースボタンの名前を持つ
    //例：UIButton test = SourceButtons["up"] としてやるとupのソースボタンがtestに代入される
    var SourceButtons = Dictionary<String, UIButton>()
    
    //createSourceButtonメソッドの引数buttonSizeにて用いる定数
    let SourceButtonSizeForSquare = CGSizeMake(38,38)    //正方形のソースボタンのサイズ
    let SourceButtonSizeForRectangle = CGSizeMake(76,38) //長方形のソースボタンのサイズ
    
    //ソースボタンを作成する
    private func createSourceButton(image: String, buttonSize: CGSize, buttonPosition: CGPoint, tag: Int) -> UIButton{
        let button = UIButton()
        button.setImage(UIImage(named:image), forState: UIControlState.Normal)
        button.frame.size = buttonSize            //ボタンのサイズ
        button.layer.position = buttonPosition    //ボタンの位置
        button.tag = tag                          //ボタンそれぞれに一意なタグを付与
        button.addTarget(self, action: "onTapSourceButtons:", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    //もともとはviewDidLoadに書いてたけど見た目ヤバいのでメソッドに移しました
    //やってることは単純でDictionaryの中にボタン入れていってるだけです
    //ボタンの位置は手動で打ったけど将来的には自動で配置できるようにしたい？
    private func SourceButtonsDidLoad(){
        SourceButtons["move"] = self.createSourceButton("SourceButton_move", buttonSize: SourceButtonSizeForRectangle, buttonPosition: CGPoint(x: 50, y: 32),  tag: 10)
        SourceButtons["attack"] = self.createSourceButton("SourceButton_attack", buttonSize: SourceButtonSizeForRectangle, buttonPosition: CGPoint(x: 152, y: 32),  tag: 11)
        SourceButtons["up"] = self.createSourceButton("SourceButton_up", buttonSize: SourceButtonSizeForRectangle, buttonPosition: CGPoint(x: 101, y: 107),  tag: 12)
        SourceButtons["left"] = self.createSourceButton("SourceButton_left", buttonSize: SourceButtonSizeForRectangle, buttonPosition: CGPoint(x: 50, y: 170),  tag: 13)
        SourceButtons["right"] = self.createSourceButton("SourceButton_right", buttonSize: SourceButtonSizeForRectangle, buttonPosition: CGPoint(x: 152, y: 170),  tag: 14)
        SourceButtons["down"] = self.createSourceButton("SourceButton_down", buttonSize: SourceButtonSizeForRectangle, buttonPosition: CGPoint(x: 101, y: 233),  tag: 15)
        SourceButtons["1"] = self.createSourceButton("SourceButton_1", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 34, y: 309),  tag: 1)
        SourceButtons["2"] = self.createSourceButton("SourceButton_2", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 101, y: 309),  tag: 2)
        SourceButtons["3"] = self.createSourceButton("SourceButton_3", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 171, y: 309),  tag: 3)
        SourceButtons["4"] = self.createSourceButton("SourceButton_4", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 34, y: 372),  tag: 4)
        SourceButtons["5"] = self.createSourceButton("SourceButton_5", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 101, y: 372),  tag: 5)
        SourceButtons["6"] = self.createSourceButton("SourceButton_6", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 171, y: 372),  tag: 6)
        SourceButtons["7"] = self.createSourceButton("SourceButton_7", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 34, y: 435),  tag: 7)
        SourceButtons["8"] = self.createSourceButton("SourceButton_8", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 101, y: 435),  tag: 8)
        SourceButtons["9"] = self.createSourceButton("SourceButton_9", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 171, y: 435),  tag: 9)
        SourceButtons["0"] = self.createSourceButton("SourceButton_0", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 101, y: 498),  tag: 0)
        SourceButtons["semicolon"] = self.createSourceButton("SourceButton_semicolon", buttonSize: SourceButtonSizeForSquare, buttonPosition: CGPoint(x: 34, y: 573),  tag: 16)
        
        //ソースボタンそれぞれをSourceButtonScrollViewのSubviewに追加する（これやらないとボタンが見えない）
        for buttonKey in SourceButtons.keys {
            self.SourceButtonScrollView.addSubview(SourceButtons[buttonKey]!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SourceButtonsDidLoad()  //ソースボタンを作成、表示させる
        self.CalculateSourceCost()   //ソースコストを表示
        self.DisplaySourceCostBar()  //ソースゲージを表示

        //SourceButtonScrollViewをストーリーボードのと違う縦幅にすることでスクロールするようになる
        self.SourceButtonScrollView.contentSize = CGSizeMake(202, 620);
        
        SourceCostFrame.layer.borderWidth = 2 //ラベルのボーダーサイズを設定
        SourceCostBarFor1Scale = 180.0 / Float(SourceCostLimit) //ソースゲージ１目盛り分の長さ = 180(枠の幅） / コスト上限値
    }
    
    //現在のソースコストを再計算する
    //コストの値が変更することがあれば必ず呼んでください
    func CalculateSourceCost(){
        self.CostLabel.text = String(SourceCostNow) + " / " + String(SourceCostLimit)
    }
    
    //ソースゲージを表示する
    //これもコストの値が変更することがあれば必ず呼んでください
    func DisplaySourceCostBar(){
        //古いコストゲージをviewから削除する、これやらずにaddSubviewしまくるとメモリが死ぬ
        if (self.SourceCostBar.isDescendantOfView(self.view)) {
            self.SourceCostBar.removeFromSuperview()
        }
        
        //ソースコストの値に合わせて表示するゲージの長さを変える
        //CGFloat(Float(SourceCostNow)*SourceCostBarFor1Scale)は見た目気持ち悪いけど
        //（現在のコスト）*（１ゲージ分の幅）をCGFloat型で算出してるだけです
        SourceCostBar.frame = CGRectMake(0,0,CGFloat(Float(SourceCostNow)*SourceCostBarFor1Scale),20)
        
        //こっちはもっと気持ち悪くなってしまった
        //xcodeの仕様上、positionで指定する座標はviewの中央となり、ただ幅を増やすだけだと左右両方に伸びます
        //なので左に伸びた分右に表示位置をずらしています
        //それとCGPointがintで値を返せってうるさいのでintに変換してます
        SourceCostBar.layer.position = CGPoint(x: 295+(SourceCostNow*Int(SourceCostBarFor1Scale)/2),y: 33)
        
        SourceCostBar.backgroundColor = UIColor.greenColor()
        self.view.addSubview(SourceCostBar)
    }
    
    
    //それぞれのフラグを条件にしてテキストを表示する関数
    //条件が合わないなら”適切なプログラミングを書いてください。”と表示する
    //(例)"1"ボタンを押すにはarrowフラグがtrueでないといけなく、その直前の”right”などのボタンを押した時にarrowフラグはtrueになる
    //この関数はonTapSourceButtons関数のSwitch文で使われている
    
    func showSourceText_number(num: String){ //数字に関するフラグ関数
        if(canPutArrowMethodFlag == true){
            if((SourceCostNow + num.toInt()!) > SourceCostLimit){ //ソースコストが上限値を突破したらエラー吐かせる
                myErrorText.text = "コストが上限値を突破してしまいます"
            }else{
                myErrorText.text = ""
                myCodeText.text = myCodeText.text + num
                canPutArrowMethodFlag = false
                canPutNumberMethodFlag = true
                //数字メソッドはコスト移動距離分なので引数numをintに変換してSourceCostに足す
                self.SourceCostNow = self.SourceCostNow + num.toInt()!
                self.CalculateSourceCost() //ソースコスト表示更新
                self.DisplaySourceCostBar()  //ソースゲージを更新
            }
        }else{
            myErrorText.text = "適切なプログラミングを書いてください"
        }
    }
    
    func showSourceText_action(act: String){//行動に関する
        if(canPutResetMethodFlag == true){
            if((SourceCostNow + 1) > SourceCostLimit){ //ソースコストが上限値を突破したらエラー吐かせる
                myErrorText.text = "コストが上限値を突破してしまいます"
            }else{
                myErrorText.text = ""
                myCodeText.text = myCodeText.text + act + "("
                canPutResetMethodFlag = false
                canPutActionMethodFlag = true
                //アクションメソッドはコスト１のためSourceCostに１を足す
                self.SourceCostNow = self.SourceCostNow + 1
                self.CalculateSourceCost() ////ソースコスト表示更新
                self.DisplaySourceCostBar()  //ソースゲージを更新

            }
        }else{
            myErrorText.text = "適切なプログラミングを書いてください"
        }
    }
    
    func showSourceText_arrow(arr: String){//矢印に関する
        if(canPutActionMethodFlag == true){
            myErrorText.text = ""
            myCodeText.text = myCodeText.text + arr + ", "
            canPutActionMethodFlag = false
            canPutArrowMethodFlag = true
        }else{
            myErrorText.text = "適切なプログラミングを書いてください"
        }

    }
    func showSourceText_semicolon(colon: String){//セミコロン
        if(canPutNumberMethodFlag == true){
            myErrorText.text = ""
            myCodeText.text = myCodeText.text + ")"+colon+"\n"
            canPutResetMethodFlag = true
            canPutNumberMethodFlag = false
        }else{
            myErrorText.text = "適切なプログラミングを書いてください"
        }
        
    }

    //ソースボタンをタップした時に呼び出される
    //ソースボタンそれぞれにはtagがふってあるのでそれで場合分けしてる
    //どのケースがどのボタンかはコメント参照
    func onTapSourceButtons(sender: UIButton) {
        switch(sender.tag) {
            case 0:     //"0"
                println(sender.tag)
                showSourceText_number("0")
            case 1:     //"1"
                println(sender.tag)
                showSourceText_number("1")
            case 2:     //"2"
                println(sender.tag)
                showSourceText_number("2")
            case 3:     //"3"
                println(sender.tag)
                showSourceText_number("3")
            case 4:     //"4"
                println(sender.tag)
                showSourceText_number("4")
            case 5:     //"5"
                println(sender.tag)
                showSourceText_number("5")
            case 6:     //"6"
                println(sender.tag)
                showSourceText_number("6")
            case 7:     //"7"
                println(sender.tag)
                showSourceText_number("7")
            case 8:     //"8"
                println(sender.tag)
                showSourceText_number("8")
            case 9:     //"9"
                println(sender.tag)
                showSourceText_number("9")
            case 10:    //"move"
                println(sender.tag)
                showSourceText_action("move")
            case 11:    //"attack"
                println(sender.tag)
                showSourceText_action("attack")
            case 12:    //"up"
                println(sender.tag)
                showSourceText_arrow("up")
            case 13:    //"left"
                println(sender.tag)
                showSourceText_arrow("left")
            case 14:    //"right"
                println(sender.tag)
                showSourceText_arrow("right")
            case 15:    //"down"
                println(sender.tag)
                showSourceText_arrow("down")
            case 16:    //";"
                println(sender.tag)
                showSourceText_semicolon(";")
            default:    //どの場合でもない、これが出たらバグです
                println("ぬる")
        }
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
