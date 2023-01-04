//
//  CaptureViewController.swift
//  AVCaptureImagePickerCrazy
//
//  Created by Tomato on 2022/12/24.
//

import UIKit
import AVFoundation

class CaptureViewController: UIViewController, AVCapturePhotoCaptureDelegate {
	private let session = AVCaptureSession()
	private let sessionQueue = DispatchQueue(label: "session queue")
	let photoOutput = AVCapturePhotoOutput()
	
	enum CameraCase {
		case front
		case back
	}
	
	
	// MARK: - IBOutlet
	@IBOutlet private weak var previewView: PreviewView!
	
	
	// MARK: - IBAction
	@IBAction func selectTapped(_ sender: UIButton) {
		snapPicture()
	}
	
	@IBAction func nextTapped(_ sender: UIButton) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		if let viewController = storyboard.instantiateViewController(withIdentifier: "ShowViewController") as? ShowViewController {
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		previewView.session = session
		sessionQueue.async {
			self.configureSession(cameraCase: .back)
			self.session.startRunning()
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	
	// MARK: - Camera
	private func configureSession(cameraCase: CameraCase) {
		session.beginConfiguration()
		
		// Add video input.
		do {
			let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraCase == .front ? .front : .back)
			let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice!)
			session.addInput(videoDeviceInput)
		}
		catch {
			print("Couldn't create video device input: \(error)")
			session.commitConfiguration()
			return
		}
		
		// Add photo output.
		session.addOutput(photoOutput)
		session.commitConfiguration()
	}
	
	func snapPicture() {
		sessionQueue.async {
			self.photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
		}
	}
	
	
	// MARK: - Delegate methods
	func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		if error == nil {
			// https://stackoverflow.com/questions/46852521/how-to-generate-an-uiimage-from-avcapturephoto-with-correct-orientation
			guard let imageData = photo.fileDataRepresentation() else {
				print("Error while generating image from photo capture data.");
				return
			}
			
			if let image = UIImage(data: imageData) {
				let ratio = image.size.width / image.size.height
				print("******** \(image.size) ratio: \(ratio)")
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				if let viewController = storyboard.instantiateViewController(withIdentifier: "ShowViewController") as? ShowViewController {
					viewController.myImage = image
					navigationController?.pushViewController(viewController, animated: true)
				}
			}
		}
	}
}

// https://medium.com/@quangtqag/simple-photo-capture-using-avcapturesession-b531c2f090b3
