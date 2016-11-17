//
//  UIImageView+AsynLoad.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL url: URL) {
        
        if url.isFileURL {
            self.image = UIImage(contentsOfFile: url.path)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Failed fetching image:\(error)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Not a proper HTTPURLResponse or statusCode")
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
}
