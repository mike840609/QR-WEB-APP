//
//  QR-GENViewController.swift
//  webBrowser
//
//  Created by 蔡鈞 on 2016/1/8.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class QR_GENViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    //暫存圖片 CoreImage
    var qrcodeImage: CIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction method implementation
    //create qrcode & delete old image
    //generate & clear
    
    @IBAction func performButtonAction(sender: AnyObject) {
        //判斷是否為nil來分辨是否產生qrcode
        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            //input message
            let data = textField.text!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            //input CorrectionLevel L M Q H
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("H", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter!.outputImage
            
            //隱藏鍵盤
            textField.resignFirstResponder()
            
            //Generate -> Clear  Show the sliderBar
            btnAction.setTitle("Clear", forState: UIControlState.Normal)
            
            displayQRCodeImage()
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            
            //remove image
            btnAction.setTitle("Generate", forState: UIControlState.Normal)
        }
        //按鈕可以編輯 按鈕編輯切換
        textField.enabled = !textField.enabled
        slider.hidden = !slider.hidden
    }
    
    
    @IBAction func changeImageViewScale(sender: AnyObject) {
        imgQRCode.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
    }
    
    
    // MARK: Custom method implementation
    
    func displayQRCodeImage() {
        //修正圖片比例 回傳圖片外框
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        //CIImage transfer to UIImage
        imgQRCode.image = UIImage(CIImage: transformedImage)
    }
    
    
}

