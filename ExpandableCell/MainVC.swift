//
//  MainVC.swift
//  ExpandableCell
//
//  Created by Nick on 2018/12/1.
//  Copyright © 2018 kcin.nil.app. All rights reserved.
//

import UIKit

final class MainVC: UIViewController {
    
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.setTitle("測試", for: .normal)
        button.mLay(size: CGSize(width: 180, height: 80))
        button.mLayCenterXY()
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(testExpand), for: .touchUpInside)
    }
    
    @objc private func testExpand() {
        
        let data11 = DataCollection(string: "第一層第一個")
        let data12 = DataCollection(string: "第一層第二個")
        let data13 = DataCollection(string: "第一層第三個")

        data11.subDatas = getFloor02()
        data12.subDatas = getFloor02()
        data13.subDatas = getFloor02()

        let nextVC = ExpandTableVC(models: [data11, data12, data13])
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func gatFloor03() -> [DataCollection] {
        let data31 = DataCollection(string: "       第三層第一個")
        let data32 = DataCollection(string: "       第三層第二個")
        let data33 = DataCollection(string: "       第三層第三個")
        return [data31, data32, data33]
    }
    
    private func getFloor02() -> [DataCollection] {
        let data21 = DataCollection(string: "   第二層第一個")
        let data22 = DataCollection(string: "   第二層第二個")
        let data23 = DataCollection(string: "   第二層第三個")
        data21.subDatas = gatFloor03()
        data22.subDatas = gatFloor03()
        data23.subDatas = gatFloor03()
        return [data21, data22, data23]
    }
}
