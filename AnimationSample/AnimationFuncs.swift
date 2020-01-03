

/******************** Basic Animation Functions ********************/
// 1
//        UIView.animate(withDuration: 3) {
//            self.button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
//        }

// 2
//        UIView.animate(withDuration: 3, animations: {
//            self.button.transform = CGAffineTransform(scaleX: 5, y: 5)
//        }) { _ in
//            self.button.removeFromSuperview()
//        }

// 3
//        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.autoreverse, .repeat], animations: {
//            self.button.transform = CGAffineTransform(scaleX: 5, y: 5)
//        }, completion: { _ in
//            self.button.transform = .identity
//        })
//

// 4
//        UIView.animate(withDuration: 10, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 50, options: [.curveLinear], animations: {
//            self.button.transform = CGAffineTransform(translationX: 0, y: -200 )
//        }, completion: nil)

// 5
//        UIView.animateKeyframes(withDuration: 3, delay: 0.0, options: [], animations: {
//
//            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
//
//            }
//            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1) {
//
//            }
//            UIView.addKeyframe(withRelativeStartTime: 2.0, relativeDuration: 1) {
//
//            }
//        }, completion: nil)

/********************  ********************/
