//
//  ViewController.swift
//  Animation Box
//
//  Created by omrobbie on 13/07/18.
//  Copyright © 2018 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables
    let boxPerRow = 10
    let colorData:Array = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
    
    var cells = [String:UIView]()
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        let width = Int(view.frame.width) / boxPerRow
        let height = Int(view.frame.height) / width
        
        for i in 0 ... boxPerRow {
            for j in 0 ... height * 2{
                let box:UIView = UIView()

                box.frame = CGRect(x: i * width, y: j * width, width: width, height: width)
                box.backgroundColor = colorData[Int(arc4random_uniform(UInt32(colorData.count)))]
                box.layer.borderWidth = CGFloat(1)
                box.layer.borderColor = UIColor.gray.cgColor
                
                view.addSubview(box)
                
                let key = "\(i)|\(j)"
                cells[key] = box
            }
        }
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(pan)
    }
    
    // MARK: Custom Functions
    @objc func handlePan(_ gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        let width = (view.frame.width / CGFloat(boxPerRow))
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        
        let key = "\(i)|\(j)"
        let viewCell = cells[key]
        
        UIView.animate(withDuration: 0.5, animations: {
            viewCell?.backgroundColor = self.colorData[Int(arc4random_uniform(UInt32(self.colorData.count)))]
            viewCell?.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        }) { (true) in
            viewCell?.transform = CGAffineTransform.identity
        }
    }

}
