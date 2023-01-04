//
//  ViewController.swift
//  AVCaptureImagePickerCrazy
//
//  Created by Tomato on 2022/12/24.
//

import UIKit

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	// MARK: - IBOutlet
	@IBOutlet weak var imageView: UIImageView!
	
	
	// MARK: - IBAction
	@IBAction func buttonTapped(_ sender: UIButton) {
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.allowsEditing = true
		vc.delegate = self
		present(vc, animated: true)
	}
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true)
		guard let image = info[.editedImage] as? UIImage else {
			print("No image found")
			return
		}
		imageView.image = image
	}
}

