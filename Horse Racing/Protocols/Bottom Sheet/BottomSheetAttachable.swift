//
//  AttatchableBottomSheet.swift
//  Horse Racing
//
//  Created on 03/08/2021.
//

import UIKit

/// Attach to the View Controller which should have the ability to present a bottom sheet
protocol BottomSheetAttachable: UIViewController, BottomSheetDataSource {
    func displayBottomSheet()
}

extension BottomSheetAttachable {
    
    /// Provides by default the ability to present a bottom sheet, with the correct configurations
    func displayBottomSheet() {
        let vc = ModalContainerViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.dataSource = self
        self.present(vc, animated: false)
    }
}
