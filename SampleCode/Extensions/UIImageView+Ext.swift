//
//  UIImageView+Ext.swift
//  SampleCode
//
//  Created by  KenNguyen on 7/19/21.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    
    func kfImageURL(_ url : String?, placeHolder : UIImage? = nil) {
        guard let imageURLString =  url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        if let url = URL.init(string: leftTrim(imageURLString, ["/"])) {
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: placeHolder,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    self.image = value.image
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func leftTrim(_ str: String, _ chars: Set<Character>) -> String {
        if let index = str.firstIndex(where: {!chars.contains($0)}) {
            let url = String(str[index..<str.endIndex])
            if !(url.contains("http") || url.contains("https")) {
                return "http://\(url)"
            }
            return url
        } else {
            return ""
        }
    }
    
    var imageSizeAfterAspectFit: CGSize {
        var newWidth: CGFloat
        var newHeight: CGFloat

        guard let image = image else { return frame.size }

        if image.size.height >= image.size.width {
            newHeight = frame.size.height
            newWidth = ((image.size.width / (image.size.height)) * newHeight)

            if CGFloat(newWidth) > (frame.size.width) {
                let diff = (frame.size.width) - newWidth
                newHeight = newHeight + CGFloat(diff) / newHeight * newHeight
                newWidth = frame.size.width
            }
        } else {
            newWidth = frame.size.width
            newHeight = (image.size.height / image.size.width) * newWidth

            if newHeight > frame.size.height {
                let diff = Float((frame.size.height) - newHeight)
                newWidth = newWidth + CGFloat(diff) / newWidth * newWidth
                newHeight = frame.size.height
            }
        }
        return .init(width: newWidth, height: newHeight)
    }
}

extension UIImage {
    func tintImageColor(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
