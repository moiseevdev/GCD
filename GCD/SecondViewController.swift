//
//  SecondViewController.swift
//  GCD
//
//  Created by Андрей Моисеев on 11.03.2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    var imageURL: URL?
    var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndecator.startAnimating()
            activityIndecator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(1){
            self.infoAlert()
        }
        
    }
    
    func delay(_ delay: Int, clousers: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            clousers()
        }
    }
    
    func infoAlert() {
        let ac = UIAlertController(title: "Information", message: "Test information", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    func fetchImage() {
        imageURL = URL(string: "https://student.itmo.ru/admin/uploads/photo/5d7a47b361f91929086664.jpg")
        activityIndecator.isHidden = false
        activityIndecator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }

}
