//
//  UIImageView+Download.swift
//  contacts
//
//  Created by prathvi on 06/09/19.
//  Copyright © 2019 Langtango. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView: ActivityIndicatorViewable  {
    
    func image(url:String?, placeholderImage: UIImage? = nil, showActivityIndicator:Bool = false, options:KingfisherOptionsInfo? = nil, completionHandler:CompletionHandler? = nil) {
        
        guard let url = url else {
            if let placeholder = placeholderImage {
                self.image = placeholder
            }
            return
        }
        
        guard let imageURL = URL(string: url) else {
            plog("Could not download image for url:\(url)")
            return
        }
        
        ImageDownloader.default.downloadTimeout = 120.0
        
        if showActivityIndicator {
            self.showActivityIndicator(in: self)
        }
        
        self.kf.setImage(with: imageURL, placeholder: placeholderImage, options: [], progressBlock: nil) { (image, error, cacheType, url) in
            
            if showActivityIndicator {
                self.hideActivityIndicator(from: self)
            }
            
            if let completionHandler = completionHandler {
                completionHandler(image, error, cacheType, url)
            }
        }
    }
    
    func imageRefresh(url:String?, showActivityIndicator:Bool = true, options:KingfisherOptionsInfo? = nil, completionHandler:CompletionHandler? = nil) {
        
        guard let url = url else { return }
        
        guard let imageURL = URL(string: url) else {
            plog("Could not download image for url:\(url)")
            return
        }
        
        ImageDownloader.default.downloadTimeout = 120.0
        
        plog("******image for url:\(imageURL)")
        
        self.kf.setImage(with: imageURL, placeholder: nil, options: [.forceRefresh], progressBlock: nil) { (image, error, cacheType, url) in
            
            
            if let completionHandler = completionHandler {
                completionHandler(image, error, cacheType, url)
            }
        }
    }
    
    func imageWithPlaceHolder(url:String?, showActivityIndicator:Bool = true, options:KingfisherOptionsInfo? = nil, completionHandler:CompletionHandler? = nil,placeholder: UIImage?) {
        
        guard let url = url else { return }
        
        guard let imageURL = URL(string: url) else {
            plog("Could not download image for url:\(url)")
            return
        }
        
        ImageDownloader.default.downloadTimeout = 120.0
        
        plog("image for url:\(imageURL)")
        
        self.kf.setImage(with: imageURL, placeholder: placeholder, options: [.fromMemoryCacheOrRefresh], progressBlock: nil) { (image, error, cacheType, url) in
            
            if let completionHandler = completionHandler {
                completionHandler(image, error, cacheType, url)
            }
        }
    }
    
    func placeholder() {
        self.placeholder(imageName: "placeholder")
    }
    
    func placeholder(imageName:String?) {
        
        guard let imageName = imageName else {
            self.placeholder(imageName: "placeholder")
            return
        }
        
        guard let image =  UIImage(named: "placeholder") else {
            self.placeholder(imageName: "placeholder")
            return
        }
        
        self.image  =   image
    }
    
    func cancelDownload() {
        self.kf.cancelDownloadTask()
    }
}
