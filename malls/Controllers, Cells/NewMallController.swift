//
//  NewMallController.swift
//  malls
//
//  Created by Anna Nosyk on 21.01.2021.
//

import UIKit

class NewMallController: UITableViewController {
   
    
    var imageIsChanged = false
    
    @IBOutlet weak var imageOfItem: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveBtn.isEnabled = false
        nameTextField.addTarget(self, action: #selector(changeTextField), for: .editingChanged)
        

    
    }
    // MARK: - TableView Delegate
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //alert for adding photo
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let galleryIcon = #imageLiteral(resourceName: "photo")
            let alert = UIAlertController(title: nil,
                                          message: nil,
                                          preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "From camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
           
            
            let gallery = UIAlertAction(title: "From gallery", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            gallery.setValue(galleryIcon, forKey: "image")
         
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(camera)
            alert.addAction(gallery)
            alert.addAction(cancel)
            present(alert, animated: true)
            
            
        } else {
            // hide keyboard tap outside row
            view.endEditing(true)
        }
    }
    
    func saveNewMall () {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = imageOfItem.image
        } else {
            image = UIImage(named: "mall")
        }

        let imageData = image?.pngData()
        let newMall = Malls(name: nameTextField.text!,
                            location: locationTextField.text,
                            imageData: imageData)
        
        StorageManager.saveObject(newMall)
 
        

    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}

// MARK: - TextField Delegate

extension NewMallController: UITextFieldDelegate {
    
    // hide keyboard (btn "Done")
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func changeTextField () {
        
        if nameTextField.text?.isEmpty == false {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
}

// MARK: - ImagePicker

extension NewMallController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfItem.image = info[.editedImage] as? UIImage
        imageOfItem.contentMode = .scaleAspectFill
        imageOfItem.clipsToBounds = true
        dismiss(animated: true)
    }
}

