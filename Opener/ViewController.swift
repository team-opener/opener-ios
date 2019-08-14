//
//  ViewController.swift
//  Opener
//
//  Created by 김성현 on 14/08/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class ViewController: UIViewController {
    
    //MARK: AV 프로퍼티
    
    var session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var capturePhotoOutput = AVCapturePhotoOutput()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAVCapture()
        startCaptureSession()
    }

    func setupAVCapture() {
        // AVCapture를 설정합니다.
        session.sessionPreset = .vga640x480
        
        guard let frontCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first else {
            os_log("전면 카메라에 접근할 수 없음", log: OSLog.default, type: .error)
            return
        }
        
        let deviceInput: AVCaptureDeviceInput
        do {
            deviceInput = try AVCaptureDeviceInput(device: frontCamera)
        } catch {
            os_log("비디오 입력 장치를 생성할 수 없음", log: OSLog.default, type: .error)
            return
        }
        
        guard session.canAddInput(deviceInput) else {
            os_log("입력 장치를 세션에 추가할 수 없음", log: OSLog.default, type: .error)
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        
        guard session.canAddOutput(capturePhotoOutput) else {
            os_log("캡쳐 사진 출력을 세션에 추가할 수 없음", log: OSLog.default, type: .error)
            session.commitConfiguration()
            return
        }
        session.addOutput(capturePhotoOutput)
        
        // 프리뷰를 설정합니다.
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
    }
    
    func startCaptureSession() {
        session.startRunning()
    }

}

