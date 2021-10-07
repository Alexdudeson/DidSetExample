//
//  ViewController.swift
//  DidSetExample
//
//  Created by Alexey Yarov on 07/10/2021.
//  Copyright © 2021 Alexey Yarov. All rights reserved.
//

import UIKit

class Observer <T> {
    var value: T? {
        didSet {
            observerBlock?(value)
        }
    }
    
    init (value: T?){
        self.value = value
    }
    
    private var observerBlock: ((T?) -> Void)?
    
    func add(_ observer: @escaping (T?) -> Void) {
        self.observerBlock = observer
    }
}

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fruits.value?[indexPath.row]
        return cell
    }
    
    
    private let table: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var fruits = Observer(value: ["Apple","Orange","Grapes"])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.frame = view.bounds
        table.dataSource = self
        
        fruits.add{[weak self] fruits in
            print("Updated fruits: \(fruits ?? [])\n\n")
            
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
        
        let more = ["Grapes","Cherry","Peach","Melon","Mango","Kebab?","Watermelon"]
        
        for x in 0..<15 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (1 * TimeInterval(x))){
                self.fruits.value?.append(more.randomElement() ?? "Something else")
            }
        }
        
//        let custom = CustomLabelView()
//        custom.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        custom.center = view.center
//        view.addSubview(custom)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//            custom.score = "32"
//        })
        
        }
    }


