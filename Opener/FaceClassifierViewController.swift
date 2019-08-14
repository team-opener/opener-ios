//
//  FaceClassifierViewController.swift
//  Opener
//
//  Created by 김성현 on 14/08/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit
import AVFoundation
import Vision
import os.log

class FaceClassifierViewController: VideoCaptureViewController {
    
    //MARK: Vision 프로퍼티
    private var requests = [VNRequest]()
    
    //MARK: 프로퍼티
    var memberInfo: VNClassificationObservation!
    var capturedPhoto: UIImage?
    private var isEntry: Bool!
    
    //MARK: Segue 액션
    
    @IBSegueAction func entrySelected(_ coder: NSCoder) -> FaceClassifierViewController? {
        let viewController = FaceClassifierViewController()
        viewController.isEntry = true
        return viewController
    }
    
    @IBSegueAction func exitSelected(_ coder: NSCoder) -> FaceClassifierViewController? {
        let viewController = FaceClassifierViewController()
        viewController.isEntry = true
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: Vision
    
    func setupVision() {
        
        guard let modelURL = Bundle.main.url(forResource: "FaceClassifier", withExtension: "mlmodelc") else {
            os_log("ML 모델을 찾을 수 없음", log: OSLog.default, type: .error)
            return
        }
        
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let faceClassification = VNCoreMLRequest(model: visionModel) { (request, error) in
                DispatchQueue.main.async {
                    if let results = request.results {
                        // 신뢰할 수 있는 결과면 표시합니다.
                        if let result = self.highConfidenceVisionResult(from: results, threshold: 96) {
                            self.capturePhoto()
                            self.showVisionResult(result)
                        }
                    }
                }
            }
            requests = [faceClassification]
        } catch {
            os_log("ML 모델 로드 실패", log: OSLog.default, type: .error)
            return
        }
        
    }
    
    func highConfidenceVisionResult(from results: [Any], threshold: VNConfidence) -> VNClassificationObservation? {
        guard let top = results.first! as? VNClassificationObservation else {
            os_log("잘못된 Vision Result 타입", log: OSLog.default, type: .error)
            return nil
        }
        if top.confidence > threshold {
            return top
        }
        return nil
    }
    
    
    
    func showVisionResult(_ result: VNClassificationObservation) {
        performSegue(withIdentifier: "LiveViewToMemberInfo", sender: self)
    }
    
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
    }
    
    override func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let photoData = photo.fileDataRepresentation() else {
            return
        }
        let photo = UIImage(data: photoData)
        capturedPhoto = photo
    }
    
}
