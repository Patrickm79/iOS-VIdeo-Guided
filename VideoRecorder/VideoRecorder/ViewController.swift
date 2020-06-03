//
//  ViewController.swift
//  VideoRecorder
//
//  Created by Paul Solt on 10/2/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// TODO: get permission
		requestPremissionAndShowCamera()
		showCamera()
		
	}
	
    private func requestPremissionAndShowCamera() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            //2nd time user has used app (they've already authorized)
            showCamera()
        case .denied:
            // 2nd time user has used app (they have not given permission)
            // take to settings app (or show a custom onboarding screen to explain why access is needed)
            fatalError("Show user UI to get them to give access")
        case .notDetermined:
            // 1st time user is using app
            requestCameraPermission()
        case .restricted:
            // Parental Controls ( need to inform user they don't have access, maybe talk to parents?)
            fatalError("Show user UI to request permission from boss/parent/self")
        }
    }
    
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (granted) in
            guard granted else {
                fatalError("Show user UI to get them to give access")
               // return // TODO: SHow UI for getting privacy permission
            }
            DispatchQueue.main.async {
                self.showCamera()
            }
        }
    }
	private func showCamera() {
		performSegue(withIdentifier: "ShowCamera", sender: self)
	}
}
