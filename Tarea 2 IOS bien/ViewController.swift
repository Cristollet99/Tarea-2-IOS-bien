//
//  ViewController.swift
//  Tarea 2 IOS bien
//
//  Created by Cristobal Lletget Luque on 18/1/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPass: UITextField!
    
    var email:String?
    var password:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //METODO PUT LOGIN
    @IBAction func loginAction(_ sender: UIButton) {
        
        email = loginEmail.text
        password = loginPass.text
        
        if let email = email, let password = password {
            let userLogin = loginUser(email: email, password: password)
            
            NetworkingProvider.shared.login(user: userLogin) { user in
                //                print(user)
                                
                if let user_token = user?.token {
                    UserDefaults.standard.set(user_token, forKey: "token")
                }
            } failure: { error in
                print(error)
            }
            
            
            //                NetworkingProvider.shared.login(user: userLogin) { user in
            //                    print(user?.token)
            //                    UserDefaults.standard.set(user?.token, forKey: "token")
            //                } failure: { error in
            //                    print(error)
            //                }
        }
    }
    
    
    //METODO PUT REGISTRO
    @IBOutlet weak var addUserName: UITextField!
    @IBOutlet weak var addUserEmail: UITextField!
    @IBOutlet weak var addUserPass: UITextField!
    @IBOutlet weak var addUserWorstation: UITextField!
    
    @IBOutlet weak var addUserSalary: UITextField!
    @IBOutlet weak var addUserBiography: UITextField!
    
    
    var name:String?
    var workstation: String?
    var salary: Int?
    var biography: String?
    
    
    @IBAction func addUserAction(_ sender: UIButton) {
        
        name = addUserName.text
        email = addUserEmail.text
        password = addUserPass.text
        workstation = addUserWorstation.text
        salary = Int(addUserSalary.text!)
        biography = addUserBiography.text
        
        
        
        
        if let name = name,let email = email, let password = password, let workstation = workstation, let salary = salary, let biography = biography   {
            let addUser = AddUser( name: name, email: email, password: password, Workstation: workstation, salary: salary, biography: biography, created_at: nil, updated_at: nil)
            
            let api_token = UserDefaults.standard.string(forKey: "token")
            
            NetworkingProvider.shared.addUser(user: addUser, api_token: api_token!) { user in
                //                print(user)
            } failure: { error in
                print(error)
            }
        }
        
    }
    
    //Recuperar contraseña POST
    
    @IBOutlet weak var emailRecovery: UITextField!
    
    
    var recoveryEmail : String?
    
    
    @IBAction func recoveryPassAction(_ sender: UIButton) {
        
        recoveryEmail = emailRecovery.text
        
        //        if let email = email, let password = password {
        //                let userLogin = loginUser(email: email, password: password)
        //
        //            NetworkingProvider.shared.login(user: userLogin) { user in
        //                print(user)
        //                UserDefaults.standard.set(user?.token, forKey: "token")
        //            } failure: { error in
        //                print(error)
        //            }
        //
        //
        //        }
        
        if let email = recoveryEmail {
            NetworkingProvider.shared.recoveryPassword(email: email){ user in
                print("Nueva contraseña enviada")
                
            }failure: { error in
                print(error)
            }
        }
    }
}
