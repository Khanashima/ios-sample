//
//  ViewController.swift
//  ios-sample
//
//  Created by 花島君俊 on 2020/05/04.
//  Copyright © 2020 花島君俊. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myDog = Dog()
        myDog.name = "Fido"
        
        let config = Realm.Configuration(
          schemaVersion: 1,
          migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
          })
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        /*
        try! realm.write {
          realm.add(myDog)
        }
        */
        let dogs = realm.objects(Dog.self)
        debugPrint(dogs[0].name)
        
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
            "Remote InstanceID token: \(result.token)"
          }
        }

    }

    

}

