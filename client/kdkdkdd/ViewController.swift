//
//  ViewController.swift
//  kdkdkdd
//
//  Created by Lanre Adelowo on 15/08/2019.
//  Copyright © 2019 Lanre Adelowo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    @IBOutlet var _username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func doLogin(_ sender: Any) {
        
        let username = _username.text!
        
        if username == "" {
            let alert = UIAlertController(title: "Authentication", message: "Please provide your username", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            return
        }
        
        Alamofire.request("https://45651f24.ngrok.io/login", method: .post, parameters: ["username" : username.lowercased()])
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
         
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Authentication failed", message: "Please try agaain", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                print(error)
            }
        }
    }
}

