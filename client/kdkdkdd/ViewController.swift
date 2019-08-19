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
    
    // The user ID retrieved from the server
    var userID : String = ""
    
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
        
        Alamofire.request("https://5024e6e1.ngrok.io/login", method: .post, parameters: ["username" : username.lowercased()])
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.userID = json["user_id"].stringValue
                
                self.performSegue(withIdentifier: "UserScreen", sender: self)
                
         
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Authentication failed", message: "Please try agaain", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender : Any?) {
        if segue.destination is UserController {
            let vc = segue.destination as? UserController
            vc?.username = _username.text!
            vc?.userID = userID
        }
    }
}

