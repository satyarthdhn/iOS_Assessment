//
//  AddressServiceMock.swift
//  SwiftUIIntergrationProjectTests
//
//  Created by Yuchen Nie on 4/10/24.
//

import Foundation
import MapKit
import ReactiveSwift
import Combine
import RxSwift

@testable import SwiftUIIntergrationProject

extension AddressService {
  //static var mock = AddressService(coordinates: coordinatesMock, asyncCoordinate: asyncCoordinateMock, coordinatePublisher: coordinatePubMock, coordinateRX: coordinateObservableMock)
  static var mock = AddressService()
}

extension AddressService {
  static func asyncCoordinateMock(from address: String) async -> CLLocationCoordinate2D? {
    return .init(latitude: 0, longitude: 0)
  }
  
  static func coordinatePubMock(from address: String) -> AnyPublisher<CLLocation?, Never> {
    Just(CLLocation.init(latitude: 0, longitude: 0)).eraseToAnyPublisher()
  }
  
  static func coordinatesMock(from address: String) -> ValueSignalProducer<CLLocation?>{
    .init(value: .init(latitude: 0, longitude: 0))
  }
  
  static func coordinateObservableMock(from address: String) -> Observable<CLLocation?> {
    Observable<CLLocation?>.just(.init(latitude: 0, longitude: 0))
  }
}
