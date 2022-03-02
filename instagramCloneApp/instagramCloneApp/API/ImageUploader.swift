//
//  imageUploader.swift
//  instagramCloneApp
//
//  Created by Ashraf on 01/03/22.
//

import FirebaseStorage

struct ImageUploader{
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error{
                print("DEBUG: Failed uploading the profile image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
    }
}
