//
//  AttatchableBottomSheet.swift
//  Horse Racing
//
//  Created on 03/08/2021.
//

import UIKit

protocol BottomSheetDataSource: AnyObject {
    var viewControllerToPresent: UIViewController { get }
    var backgroundDim: CGFloat { get }
    var defaultHeight: CGFloat { get }
    var dismissibleHeight: CGFloat { get }
    var topPadding: CGFloat { get }
}

extension BottomSheetDataSource {
    var backgroundDim: CGFloat {
        return 0.6
    }
    
    var defaultHeight: CGFloat {
        return 300
    }
    
    var dismissibleHeight: CGFloat {
        return 200
    }
    
    var topPadding: CGFloat {
        return 64
    }
}

protocol BottomSheetAttachable: UIViewController, BottomSheetDataSource {
    func displayBottomSheet()
}

extension BottomSheetAttachable {
    func displayBottomSheet() {
        let vc = ModalContainerViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.dataSource = self
        self.present(vc, animated: false)
    }
}
