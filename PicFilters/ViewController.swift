//
//  ViewController.swift
//  PicFilters
//
//  Created by Дима Холод on 13.11.2022.
//
/*
 Посмотри на такую штуку как CoreImage filters, (CIFilter)
 
 Если сможешь сделать приложение, где можно будет выбрать из фотогалерии фото и применить к нему фильтры CIPhotoEffectChrome, CIPhotoEffectMono, CIPhotoEffectNoir => поговорим
 */
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    var original: UIImage?
    let context = CIContext()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func selectPhotoButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
    // func named for test
    @IBAction func firstFilterButtonClicked(_ sender: Any) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    @IBAction func chromeClicked(_ sender: Any) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectChrome")
        filter?.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    @IBAction func monoClicked(_ sender: Any) {
        if original == nil {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectMono")
        filter?.setValue(CIImage(image: original!), forKey: kCIInputImageKey)
        let output = filter?.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
}

