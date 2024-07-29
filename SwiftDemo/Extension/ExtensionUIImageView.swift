//
//  UIImageView.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        self.image = nil
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
