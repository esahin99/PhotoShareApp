//
//  UploadViewController.swift
//  PhotoShareApp
//
//  Created by Emre Sahin on 21.01.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (storagemetadata, error) in
                if error != nil{
                    self.showErrorMessage(titleInput: "Error!", messageInput: error!.localizedDescription)
                }
                else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl{
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageurl": imageUrl, "comment": self.commentTextField.text!, "email": Auth.auth().currentUser!.email, "date": FieldValue.serverTimestamp()] as [String: Any]
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost){(error) in
                                    if error != nil{
                                        self.showErrorMessage(titleInput: "Error!", messageInput: error!.localizedDescription)
                                    }
                                    else{
                                        self.commentTextField.text = ""
                                        self.imageView.image = UIImage(named: "Choose a Photo")
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
        
    }
    
    func showErrorMessage(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }


}
