//
//  APIManager.swift
//  FilmsCollection
//
//  Created by Игорь Ущин on 23.10.2022.
//

import FirebaseFirestore
import Firebase
import Foundation

class  APIManager {
    
    static let shared = APIManager()

    private func configFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
       
    func getPost(collection: String, docName: String, completion: @escaping (Document?) -> Void) {
        let db = configFB()
        db.collection(collection).document(docName).getDocument(completion: { (document,error) in
                guard error == nil else { completion(nil); return}
                let doc = Document(Email: document?.get("Email") as? String,
                                   Password: document?.get("Password") as? String,
                                   Firstname: document?.get("First name") as? String,
                                   Lastname: document?.get("Last name") as? String,
                                   Phonenumber: document?.get("Phone number") as? String)
                    completion(doc)
            })
        }
}

