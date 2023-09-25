//
//  SignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/08/13.
//

import UIKit
import Foundation
import SafariServices

//let kCloseSafariViewControllerNotification = "kCloseSafariViewControllerNotification"

class SignInViewController: UIViewController, UIViewControllerTransitioningDelegate, SFSafariViewControllerDelegate {

    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NotificationCenter.default.addObserver(self, selector: "safariLogin", name: kCloseSafariViewControllerNotification, object: nil)
    }
    
    @IBAction func googleButtonDidTap(_ sender: UIButton) {
        // URLComponents를 사용하여 URL 구성
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "port-0-moa-spring-3prof2llkqnph83.sel4.cloudtype.app"
        urlComponents.path = "/oauth2/authorize/google"
        urlComponents.query = "requester=APP"

        // URL 구성 요소를 사용하여 URL 생성
        guard let url = urlComponents.url else { return }
        
        // URLRequest 인스턴스 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // 요청에 사용할 HTTP 메서드 설정

        // HTTP 헤더 설정
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // URLSession을 사용하여 요청 수행
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                // HTML 데이터 가져오기
                //let urlContent = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                // Safari로 띄우기
                let safariVC = SFSafariViewController(url: url)
                // delegate 지정 및 presentation style 설정.
                safariVC.transitioningDelegate = self
                safariVC.modalPresentationStyle = .pageSheet
                DispatchQueue.main.async {
                    self.present(safariVC, animated: true, completion: nil)
                }
            } else {
                print("Unexpected error")
            }
        }

        task.resume() // 작업 시작
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}
