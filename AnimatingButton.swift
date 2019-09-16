//
//  AnimatingButton.swift
//  LinesAnimation
//
//  Created by Jai Nijhawan on 16/09/19.
//

import Foundation

public class AnimatingButton: UIButton {
  //MARK: - Custom Methods
  public func animatingButton(btn:UIButton,
                       tDistance: CGFloat,
                       withDuration: Double,
                       numberOfLines: Int) {
    
    var angleOfRoatation: CGFloat
    var Tx: CGFloat
    var Ty: CGFloat
    let imageHeight: CGFloat = 30.0
    let imageWidth: CGFloat = 30.0
    btn.isEnabled = false
    var angleOfRotationInRadians: CGFloat
    
    for i in 0..<numberOfLines {
      let x = UIImageView()
      
      //Calculating frames for each View
      x.frame = CGRect(x: btn.frame.midX - imageWidth/2,
                       y: btn.frame.midY - imageHeight/2,
                       width: imageWidth,
                       height: imageHeight)
      x.image = #imageLiteral(resourceName: "Rectangle")
      x.contentMode = .scaleAspectFit
      
      angleOfRoatation = CGFloat(i)*CGFloat((360/numberOfLines))
      angleOfRotationInRadians = angleOfRoatation * CGFloat.pi / 180
      
      //Rotating Views
      x.image = imageRotatedByDegrees(oldImage: x.image!, deg:angleOfRoatation)
      
      Tx = tDistance + x.frame.width/2
      Ty = Tx
      
      btn.superview!.addSubview(x)
      
      //Animating Views
      UIView.animate(withDuration: withDuration, delay: 0,
                     options: .curveEaseInOut,
                     animations: {
                      x.transform = CGAffineTransform(translationX: Tx*cos(angleOfRotationInRadians),
                                                      y: Ty*sin(angleOfRotationInRadians))
                      
                      //Making the Views disappear
                      x.transform = x.transform.scaledBy(x: 0.01, y: 0.01)
      }) { (_) in
        //MARK: - Removing the Views from SuperView
        x.removeFromSuperview()
        btn.isEnabled = true
      }
    }
    btn.superview!.bringSubview(toFront: btn)
  }
  
  func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
    //Calculate the size of the rotated view's containing box for our drawing space
    let oldFrame = CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height)
    let rotatedViewBox: UIView = UIView(frame: oldFrame)
    let trans: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
    rotatedViewBox.transform = trans
    let rotatedSize: CGSize = rotatedViewBox.frame.size
    //Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap: CGContext = UIGraphicsGetCurrentContext()!
    //Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
    //Rotate the image context
    bitmap.rotate(by: (degrees * CGFloat.pi / 180))
    //Now, draw the rotated/scaled image into the context
    bitmap.scaleBy(x: 1.0, y: -1.0)
    let scaledRect = CGRect(x: -oldImage.size.width / 2,
                            y: -oldImage.size.height / 2,
                            width: oldImage.size.width,
                            height: oldImage.size.height)
    bitmap.draw(oldImage.cgImage!, in: scaledRect)
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }
}
