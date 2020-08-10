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
import FirebaseFirestore


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
          }
        }
        
        //firestoreの保存
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

        //firebaseのfirestoreのデータの取得
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("取得データ" + "\(document.documentID) => \(document.data())")
                }
            }
        }
    }

    

}

