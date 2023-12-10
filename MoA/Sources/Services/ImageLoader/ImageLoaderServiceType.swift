//
//  ImageLoaderServiceType.swift
//  MoA
//
//  Created by eunae on 2023/11/12.
//

import Foundation
import UIKit.UIImage
import Combine

protocol ImageLoaderServiceType: AnyObject, AutoMockable {
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never>
}
