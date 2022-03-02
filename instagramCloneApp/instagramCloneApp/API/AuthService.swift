//
//  authService.swift
//  instagramCloneApp
//
//  Created by Ashraf on 01/03/22.
//

import UIKit
import Firebase


struct AuthCredentials{
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}


struct AuthService{
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Error?) -> Void){
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error{
                    print("DEBUG: error while creating the user")
                    completion(error)
                }
                
                guard let uid = result?.user.uid else {return}
                
                let data: [String: Any] = ["email": credentials.email, "fullname": credentials.fullname, "profileImageUrl": imageUrl, "username": credentials.username, "uid": uid]

                Firestore.firestore().collection("Users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
