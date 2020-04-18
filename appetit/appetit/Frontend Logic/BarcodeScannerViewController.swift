//
//  BarcodeScannerViewController.swift
//  appetit
//
//  Created by Frank Hu on 4/6/20.
//  Copyright © 2020 Mark Kang. All rights reserved.
//

//Sample barcodes for testing
// https://docs.google.com/document/d/1hZ69q8BhEgEVHbFzQnPlGNPjyJycKWBDhY1jsT13np8/edit
//TODO: Add edge case errors for barcode with no search result from API

import UIKit
import AVFoundation

class BarcodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    let topBar = UIView()
    let scanView = UIView()
    let bottomBar = UIView()
        
        var captureSession = AVCaptureSession()
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer?
        var BarcodeFrameView: UIView?
        
        private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                           AVMetadataObject.ObjectType.code39,
                                           AVMetadataObject.ObjectType.code39Mod43,
                                           AVMetadataObject.ObjectType.code93,
                                           AVMetadataObject.ObjectType.code128,
                                           AVMetadataObject.ObjectType.ean8,
                                           AVMetadataObject.ObjectType.ean13,
                                           AVMetadataObject.ObjectType.aztec,
                                           AVMetadataObject.ObjectType.pdf417,
                                           AVMetadataObject.ObjectType.itf14,
                                           AVMetadataObject.ObjectType.dataMatrix,
                                           AVMetadataObject.ObjectType.interleaved2of5,
                                           AVMetadataObject.ObjectType.qr]
        
        override func viewDidLoad() {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                // Already Authorized
            } else {
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                   if granted == true {
                       // User granted
                   } else {
                       // User rejected
//                        self.scanningNotPossible()
                   }
               })
            }
            setupLayout()
            super.viewDidLoad()
            
            captureSession = AVCaptureSession()
            
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
             
            guard let captureDevice = deviceDiscoverySession.devices.first else {
                
                print("Failed to get the camera device")
                return
            }
             
            do {
                // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                // Set the input device on the capture session.
                captureSession.addInput(input)

                // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
                let metadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(metadataOutput)
                
                // Set delegate and use the default dispatch queue to execute the call back
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = supportedCodeTypes
    //            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                
            } catch {
                print(error)
                return
            }
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = scanView.layer.frame
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession.sessionPreset = .photo
            captureSession.startRunning()
            
            // Move the message label and top bar to the front
//            view.bringSubviewToFront(messageLabel)
//            view.bringSubviewToFront(BottomBar)
//            view.bringSubviewToFront(TopBar)
            
            // Initialize Code Frame to highlight the code
            BarcodeFrameView = UIView()
            
            if let BarcodeFrameView = BarcodeFrameView {
                BarcodeFrameView.layer.borderColor = UIColor.blue.cgColor
                BarcodeFrameView.layer.borderWidth = 2
                view.addSubview(BarcodeFrameView)
                view.bringSubviewToFront(BarcodeFrameView)
            }
        }
    
//    func scanningNotPossible(){
//        let alert = UIAlertController(title: "Can't Scan", message: "Try a device with camera", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // Check if the metadataObjects array is not nil and it contains at least one object.
            if metadataObjects.count == 0 {
                BarcodeFrameView?.frame = CGRect.zero
//                messageLabel.text = "No Barcode is detected"
                return
            }
            
            // Get first object from metadata objects array and turn it into machine readable code.
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            if supportedCodeTypes.contains(metadataObj.type) {
                
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                BarcodeFrameView?.frame = barCodeObject!.bounds
                
                if metadataObj.stringValue != nil {
                    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                    captureSession.stopRunning()
                    let numberString = metadataObj.stringValue
                    //Remove leading zeros of scanned string value for correct UPC search
                    let num = numberString!.drop { !$0.isWholeNumber || $0 == "0" }
                    DataService.searchAPI(codeNumber: String(num)){
                        foodInfo in
                        DispatchQueue.main.async{
//                            self.messageLabel.text = "Name: \(foodInfo.0) \nServing Size: \(foodInfo.1)"
                        }
                    }
//                    print ("here + \(foodInfo)")
//                    messageLabel.text = "\(foodInfo.name)"
                }
            }

        //Function when QR Code detected
//    func found(value: String) -> (name:String, qty:Float, unit:String) {
//        var name = ""
//        var qty = Float(0)
//        var unit = ""
//        DataService.searchAPI(codeNumber: value){
//            foodInfo in
//            name = foodInfo.0
//            qty = foodInfo.1
//            unit = foodInfo.2
//        }
//        print(name, qty, unit)
//        return (name, qty, unit)
//            print(scanInfo.0)
//            messageLabel.text = "\(scanInfo.0) hello"
//            let alert = UIAlertController(title: "Scanned", message: "\(value)", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title:"Search", style: UIAlertAction.Style.destructive, handler: { action in
//                DataService.searchAPI(codeNumber: value)
//                self.present(alert, animated:true, completion: nil)
//            }))
    }
            
//            let alert = UIAlertController(title: "Scanned", message: value, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Search", style: UIAlertAction.Style.destructive, handler:
//
//
//            ))
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
//                    alert.addAction(cancelAction)
        private func updatePreviewLayer(layer: AVCaptureConnection, orientation: AVCaptureVideoOrientation) {
          layer.videoOrientation = orientation
            videoPreviewLayer?.frame = self.scanView.layer.frame
        }
        
        override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          
          if let connection =  self.videoPreviewLayer?.connection  {
            let currentDevice: UIDevice = UIDevice.current
            let orientation: UIDeviceOrientation = currentDevice.orientation
            let previewLayerConnection : AVCaptureConnection = connection
            
            if previewLayerConnection.isVideoOrientationSupported {
              switch (orientation) {
              case .portrait:
                updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                break
              case .landscapeRight:
                updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeLeft)
                break
              case .landscapeLeft:
                updatePreviewLayer(layer: previewLayerConnection, orientation: .landscapeRight)
                break
              case .portraitUpsideDown:
                updatePreviewLayer(layer: previewLayerConnection, orientation: .portraitUpsideDown)
                break
              default:
                updatePreviewLayer(layer: previewLayerConnection, orientation: .portrait)
                break
              }
            }
          }
        }
        private func setupLayout() {
            topBar.backgroundColor = .blue
            view.addSubview(topBar)
            topBar.translatesAutoresizingMaskIntoConstraints = false
            topBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            topBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13).isActive = true
            
//            let scanView = UIView()
            scanView.backgroundColor = .yellow
            view.addSubview(scanView)
            scanView.translatesAutoresizingMaskIntoConstraints = false
            scanView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
            scanView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scanView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scanView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
            
//            let scanOver = UIImageView()
//            let barImage = UIImage(named: "barView")
//            scanOver.image = barImage
//
//            scanView.addSubview(scanOver)
//            scanOver.centerYAnchor.constraint(equalTo: scanView.centerYAnchor).isActive = true
//            scanOver.centerXAnchor.constraint(equalTo: scanView.centerXAnchor).isActive = true

//            let bottomBar = UIView()
            bottomBar.backgroundColor = .green
            view.addSubview(bottomBar)
            bottomBar.translatesAutoresizingMaskIntoConstraints = false
            bottomBar.topAnchor.constraint(equalTo: scanView.bottomAnchor).isActive = true
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
    }
