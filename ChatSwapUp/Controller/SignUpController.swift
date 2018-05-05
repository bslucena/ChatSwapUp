//
//  SignUpController.swift
//  ChatSwapUp
//
//  Created by Bernardo Sarto de Lucena on 5/1/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import UIKit
import Firebase

// Adding pickerview delegate and datasource
class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var genderSelectionButton: UIButton!
    @IBOutlet weak var ageSelectionButton: UIButton!
    @IBOutlet weak var genderSelectionPickerView: UIPickerView!
    @IBOutlet weak var ageSelectionPickerView: UIPickerView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addImageImageView: UIImageView!
    
    @IBAction func genderSelectedButton(_ sender: UIButton) {
        if genderSelectionPickerView.isHidden == true {
            genderSelectionPickerView.isHidden = false
        }
        
    }
    
    @IBAction func ageSelectedButton(_ sender: UIButton) {
        
        if ageSelectionPickerView.isHidden == true {
            ageSelectionPickerView.isHidden = false
        }
    }
    
    @IBAction func signUpButtonSelected(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let country = countryTextField.text, let city = cityTextField.text, let age = ageSelectionButton.currentTitle, let gender = genderSelectionButton.currentTitle else {
            print("Form is not valid")
            return
        }
        
        if passwordTextField.text == retypePasswordTextField.text, email != "", password != "", name != "", country != "", city != "", age != "", gender != "" , addImageImageView.image != UIImage(named: "addPicture") {
            Auth.auth().createUser(withEmail: email, password: password, completion: {(user: User?, error) in
                
                if error != nil {
                    self.popAlert(title: "Something Went Wrong", message: (error?.localizedDescription)!)
                    return
                } else {
                    self.performSegue(withIdentifier: "SignUpToMainPage", sender: nil)
                    
                }
                
                guard let uid = user?.uid else {
                    return
                }
                
                
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
                
                //                you can add the if let statement to avoid crashing with the unwrapping
                if let addImage = self.addImageImageView.image, let uploadData = UIImageJPEGRepresentation(addImage, 0.1) {
                    
                    //                if let uploadData = UIImageJPEGRepresentation(self.addImageImageView.image!, 0.1) {
                    //                if let uploadData = UIImagePNGRepresentation(self.addImageImageView.image!){
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        
                        if error != nil {
                            self.popAlert(title: "Something Went Wrong", message: (error?.localizedDescription)!)
                            return
                        }
                        
                        if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                            let values = ["name": name, "email": email, "country": country, "city": city, "age": age, "gender": gender, "profileImageUrl": profileImageUrl]
                            self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        }
                        
                    })
                }
                
            })
            
        } else {
            self.popAlert(title: "Alert", message: "Please fill all the fields and choose a photo.")
        }
        
        //ProfileViewController.nameLabel.text = dictionary["name"] as? String
        
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject ]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock:{ (error, ref)
            in
            
            if error != nil {
                self.popAlert(title: "Something Went Wrong", message: (error?.localizedDescription)!)
                return
            }
            
            
            print("Saved user successfully into Firebase database")
        })
    }
    
    @IBAction func backButtonSelected(_ sender: UIButton) {
    }
    
    let gender = ["", "Male", "Female"]
    var age = [""]
    
    override func viewDidLoad() {
        genderSelectionPickerView.delegate = self
        genderSelectionPickerView.dataSource = self
        ageSelectionPickerView.delegate = self
        ageSelectionPickerView.dataSource = self
        
        var sum = 0
        for _ in 0..<100 {
            sum += 1
            age.append(String(sum))
            
        }
        
        addImageImageView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector (handleSelectProfileImageView)))
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            addImageImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows: Int = age.count
        if pickerView == genderSelectionPickerView {
            countRows = self.gender.count
        }
        
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == ageSelectionPickerView {
            let titleRow = age[row]
            return titleRow
        } else if pickerView == genderSelectionPickerView {
            let titleRow = gender[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == ageSelectionPickerView {
            ageSelectionButton.setTitle(age[row], for: .normal)
            ageSelectionPickerView.isHidden = true
            
        } else if pickerView == genderSelectionPickerView {
            genderSelectionButton.setTitle(gender[row], for: .normal)
            genderSelectionPickerView.isHidden = true
            
        }
    }
    
    func popAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}
