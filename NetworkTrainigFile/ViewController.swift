//
//  ViewController.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var fetcher: NetworkDataFetcherProtocol? = NetworkDataFetcher(networkService: NetworkService.shared)
    private var queue: DispatchQueue = DispatchQueue.global(qos: .userInteractive)
    private let service: CountriesServiceProtocol = CountriesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray2
        /*
        fetcher?.getIndependentCountries(status: true, fields: nil, from: { countries in
            if let countries {
                countries.forEach({ print($0.name.common) })
            }
        })
        
        self.service.fetchCountries { result in
            switch result {
                case .success(let countries):
                    countries.forEach({ print($0.name.common) })
         print(countries)
         case .failure(let error):
         print(error.localizedDescription)
         }
         }
         
        self.service.fetchCountryBy(name: "France", fullText: false) { result in
            switch result {
                case .success(let countries):
                    print(countries.forEach({ print($0.name.common) }))
                case .failure(let error):
                    print(error.localizedDescription)
            }
         }
         
        
        self.service.fetchCountryBy(codes: ["196", "458", "678"]) { result in
            switch result {
                case .success(let countries):
                    print(countries.forEach({ print($0.name.common) }))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
         */
        self.service.fetchFields(for: "all", fields: ["name", "capital", "currencies"] ) { result in
            switch result {
                case .success(let countries):
                    print(countries.forEach({ print($0.name?.common ?? "") }))
                case .failure(let error):
                    print(error.localizedDescription)
            }}
    }
}

