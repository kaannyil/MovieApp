//
//  UIImageView+Ext.swift
//  MovieApp
//
//  Created by Kaan Yıldırım on 7.09.2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    public func imageFromUrl(urlString: String?, placeHolderImage: UIImage?) {
        image = placeHolderImage
        
        // Temel URL ye ihtiyaç var ve temel URL'sizde döndürebilir. Bu yüzden ilk önce kontrol ediyoruz.
        if var urlS = urlString {
            if !urlS.hasPrefix("http") {
                urlS = "https://image.tmdb.org/t/p/w500" + urlS
            }
            
            if let url = URL(string: urlS) {
                self.kf.setImage(with: url)
            }
        }
    }
}
