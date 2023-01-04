//
//  PreviewView.swift
//  AVCaptureImagePickerCrazy
//
//  Created by Tomato on 2022/12/26.
//

import UIKit
import AVFoundation

class PreviewView: UIView {
	var videoPreviewLayer: AVCaptureVideoPreviewLayer {
		guard let layer = layer as? AVCaptureVideoPreviewLayer else {
			fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
		}
		
		return layer
	}
	
	var session: AVCaptureSession? {
		get {
			return videoPreviewLayer.session
		}
		set {
			videoPreviewLayer.session = newValue
		}
	}
	
	// MARK: UIView
	
	override class var layerClass: AnyClass {
		return AVCaptureVideoPreviewLayer.self
	}
}
