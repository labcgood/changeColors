//
//  ViewController.swift
//  changeColors
//
//  Created by Labe on 2024/1/15.
//

import UIKit

class ViewController: UIViewController {

    //拉IBOutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var flowerIV: UIImageView!
    @IBOutlet weak var imageIV: UIImageView!
    
    
    @IBOutlet weak var redSD: UISlider!
    @IBOutlet weak var greenSD: UISlider!
    @IBOutlet weak var blueSD: UISlider!
    @IBOutlet weak var alphaSD: UISlider!
    
    @IBOutlet weak var redLB: UILabel!
    @IBOutlet weak var greenLB: UILabel!
    @IBOutlet weak var blueLB: UILabel!
    @IBOutlet weak var alphaLB: UILabel!
    
    @IBOutlet weak var clothesColorSwitch: UISwitch!
    @IBOutlet weak var frameSwitch: UISwitch!
    @IBOutlet weak var cornerSD: UISlider!
    @IBOutlet weak var shadowSD: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // [自訂] 把值傳給顯示顏色、透明度當前值的Label用的function.
    fileprivate func extractedFunc() {
        redLB.text = String(format: "%.0f", redSD.value * 255)
        greenLB.text = String(format: "%.0f", greenSD.value * 255)
        blueLB.text = String(format: "%.0f", blueSD.value * 255)
        alphaLB.text = String(format: "%.1f", alphaSD.value)
    }
    
    func setValueToLabel() {
        extractedFunc()
    }
    
    // [Slider] 調整衣服顏色.
    @IBAction func changeColors(_ sender: Any) {
        flowerIV.backgroundColor = UIColor(red: CGFloat(redSD.value), green: CGFloat(greenSD.value), blue: CGFloat(blueSD.value), alpha: CGFloat(alphaSD.value))
        setValueToLabel()
    }
    
    // [Switch] 是否開啟調整顏色,關起來Silder會隱藏,預設開啟.
    @IBAction func openColorAdjust(_ sender: UISwitch) {
//        let isOpen = sender.isOn
//        let isHide = !sender.isOn
//        redSD.isHidden = isHide
//        greenSD.isHidden = isHide
//        blueSD.isHidden = isHide
//        alphaSD.isHidden = isHide
//        ⬇︎
        
        redSD.isHidden = !sender.isOn
        greenSD.isHidden = !sender.isOn
        blueSD.isHidden = !sender.isOn
        alphaSD.isHidden = !sender.isOn
    }
    
    // [Switch] 是否開啟調整邊框,關起來Silder會隱藏,預設關起來.
    @IBAction func openFrameAdjust(_ sender: UISwitch) {
        cornerSD.isHidden = !sender.isOn
        shadowSD.isHidden = !sender.isOn
    }
    
    // [Slider] 調整邊框圓角.
    @IBAction func changeCorner(_ sender: Any) {
        flowerIV.layer.cornerRadius = CGFloat(cornerSD.value)
        imageIV.layer.cornerRadius = CGFloat(cornerSD.value)
        backgroundView.layer.cornerRadius = CGFloat(cornerSD.value)
    }
    
    // [Slider] 調整邊框陰影.
    @IBAction func changeShadow(_ sender: Any) {
        backgroundView.layer.shadowRadius = CGFloat(shadowSD.value)
        backgroundView.layer.shadowColor = CGColor(red: 184/255, green: 0, blue: 0, alpha: 1)
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: Int(shadowSD.value))
        backgroundView.layer.shadowOpacity = 1
    }
    
    // [Button] 隨機產生顏色、邊框的按鈕,如果衣服顏色、邊框Switch關起來就不會被改動,例如顏色覺得不錯但邊框不喜歡,就可以先把顏色鎖起來,繼續隨機產生邊框,選到自己滿意.
    @IBAction func randomBT(_ sender: Any) {
        if clothesColorSwitch.isOn {
            let randomColor = UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: CGFloat.random(in: 0...1))
            flowerIV.backgroundColor = randomColor
            var red: CGFloat = 0.0
            var green: CGFloat = 0.0
            var blue: CGFloat = 0.0
            var alpha: CGFloat = 0.0
            randomColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            redSD.setValue(Float(red), animated: true)
            greenSD.setValue(Float(green), animated: true)
            blueSD.setValue(Float(blue), animated: true)
            alphaSD.setValue(Float(alpha), animated: true)
        }
        
        setValueToLabel()
        
        if frameSwitch.isOn {
            let randomRadius = Float.random(in: 1...180)
            cornerSD.setValue(randomRadius, animated: true)
            changeCorner(randomRadius)
            let randomShadow = Float.random(in: 1...10)
            shadowSD.setValue(randomShadow, animated: true)
            changeShadow(randomShadow)
        }
    }
    
    // [Button] 重置按鈕(回到預設值)
    @IBAction func resetBT(_ sender: Any) {
        clothesColorSwitch.isOn = true
        redSD.value = 1
        greenSD.value = 1
        blueSD.value = 1
        alphaSD.value = 1
        changeColors(1)
        setValueToLabel()
        redSD.isHidden = false
        greenSD.isHidden = false
        blueSD.isHidden = false
        alphaSD.isHidden = false
        
        frameSwitch.isOn = false
        cornerSD.setValue(0, animated: true)
        shadowSD.setValue(0, animated: true)
        changeCorner(0)
        changeShadow(0)
        cornerSD.isHidden = true
        shadowSD.isHidden = true
    }

}

