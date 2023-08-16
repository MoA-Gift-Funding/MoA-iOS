//
//  SignInViewController.swift
//  MoA
//
//  Created by eunae on 2023/08/13.
//

import UIKit
import Foundation

class SignInViewController: UIViewController {

    @IBOutlet weak var googleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func googleButtonDidTap(_ sender: UIButton) {
        // URLComponents를 사용하여 URL 구성
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "port-0-moa-spring-3prof2llkqnph83.sel4.cloudtype.app"
        urlComponents.path = "/oauth2/authorize/google"

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
                let urlContent = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print(url)
                // Safari로 띄우기
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:])
                }
            } else {
                print("Unexpected error")
            }
        }

        task.resume() // 작업 시작
    }
    
}
