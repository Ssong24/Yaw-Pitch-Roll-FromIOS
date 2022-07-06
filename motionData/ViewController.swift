//
//  ViewController.swift
//  motionData
//
//  Created by Song on 2022/07/05.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
    
    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var yawLabel: UILabel!
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.deviceMotionUpdateInterval = 0.2
        manager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] deviceMotion, error in
            guard let deviceMotion = deviceMotion else {
                return
            }
            self?.handleDeviceMotion(deviceMotion)
//            self?.rollLabel.text  = String(myRoll);
//            self?.pitchLabel.text = String(myPitch);
//            self?.yawLabel.text   = String(myYaw);
        }

    }
    
    private func handleDeviceMotion(_ deviceMotion: CMDeviceMotion) {
        
        let quat = deviceMotion.attitude.quaternion
        
        let roll1 = quat.y * quat.w - quat.x * quat.z
        let roll2 = 1 - 2*quat.y*quat.y - 2*quat.z*quat.z
        
        let pitch1 = quat.x*quat.w + quat.y*quat.z
        let pitch2 = 1 - 2*quat.x*quat.x - 2*quat.z*quat.z
        let converting = -90.0
        
        let yaw1 = 2*quat.x*quat.y + 2*quat.w*quat.z
        
        let myRoll = (180/Double.pi) * atan2(2 * roll1, roll2)
        let myPitch = (180/Double.pi) * atan2(2 * pitch1 , pitch2)
        let myYaw = (180/Double.pi) * asin(yaw1);
        
        DispatchQueue.main.async {
            self.rollLabel.text  = String(myRoll);
            self.pitchLabel.text = String(myPitch);
            self.yawLabel.text   = String(myYaw);
        }


    }


}

