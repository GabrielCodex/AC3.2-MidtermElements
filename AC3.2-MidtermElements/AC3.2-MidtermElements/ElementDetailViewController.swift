//
//  ElementDetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by John Gabriel Breshears on 12/8/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {
    var detailElement: Element!
    var postUrl: String = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boilLabel: UILabel!
    @IBOutlet weak var meltLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.symbolLabel.text = "Symbol: \(detailElement.symbol)"
        self.numberLabel.text = "Number: \(detailElement.number)"
        self.weightLabel.text = "Weight: \(detailElement.weight)"
        self.boilLabel.text = "Boiling Point: \(detailElement.boiling)"
        self.meltLabel.text = "Melting Point: \(detailElement.melting)"
        self.messageLabel.text = "Type in your name and hit Send to post your favorite element"
        
        self.title = detailElement.name
        APIRequestManager.manager.getData(endPoint: detailElement.fullImage) { (data : Data?) in
            guard let unwrappedData = data else {return}
            DispatchQueue.main.async {
                self.elementImageView.image = UIImage(data: unwrappedData)
                self.elementImageView.setNeedsLayout()
                
                
            }
        }
        
        
        
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let favoriteElement: [String : Any] = ["my_name" : nameTextField.text!,
                               "favorite_element" : "I am getting the hang out this!! My Fav element is \(detailElement.name) because it is the lightest element, hydrogen makes up 90% of the visible universe and is the raw fuel for stars"]
        APIRequestManager.manager.postRequest(endPoint: postUrl, data: favoriteElement)
    }

       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
