//
//  ShowViewController.swift
//  AVCaptureImagePickerCrazy
//
//  Created by Tomato on 2022/12/24.
//

import UIKit

class ShowViewController: UIViewController {
	// MARK: - Variables
	var myImage: UIImage?
	
	
	// MARK: - IBOutlet
	@IBOutlet weak var imageView: UIImageView!
	
	
	// MARK: - IBAction
	@IBAction func saveTapped(_ sender: UIButton) {
		if let image = myImage {
			saveImage(image)
		}
	}
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		/*
		NotificationCenter.default.addObserver(self, selector: #selector(setImageCapturedImage), name: NSNotification.Name(rawValue: "ShowViewControllerHasImage"), object: nil)
		*/
		if let image = myImage {
			imageView.image = image
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self)
	}
	
	
	// MARK: - Notifications
	@objc func setImageCapturedImage(notification: NSNotification) {
		if let image = notification.object as? UIImage {
			imageView.image = image
		}
	}
	
	
	// MARK: - Saving an image to Photo Library
	func saveImage(_ image: UIImage) {
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError: contextInfo:)), nil)
	}
	
	@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		if let error = error {
			// we got back an error!
			print("An error has occurred: \(error.localizedDescription)")
		} else {
			print("Saved...")
		}
	}
}

