//
//  ViewController.swift
//  astkachuk_2PW1
//
//  Created by Artem Tkachuk on 13.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let maxRadiusOfView: CGFloat = 50
    }
    
    // MARK: - IBOutlets
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var button: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBasicAppearance()
    }
    
    // MARK: - Private Methods
    private func setBasicAppearance() {
        var colorSet = getUniqueColors(count: views.count + 1)
        
        self.view.backgroundColor = colorSet.popFirst()
        
        for view in views {
            view.backgroundColor = colorSet.popFirst()
            changeCornerRadius(view: view, maxRadius: Constants.maxRadiusOfView)
        }
    }
    
    private func getUniqueColors(count: Int) -> Set<UIColor> {
        var setOfColors = Set<UIColor>()
        
        while setOfColors.count < count {
            setOfColors.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1.0
                )
            )
        }
        
        return setOfColors
    }
    
    private func changeCornerRadius(view: UIView, maxRadius: CGFloat = 25 ) {
        let randomRadius = CGFloat.random(in: 0...maxRadius)
        view.layer.cornerRadius = randomRadius
    }
    
    // MARK: - IBActions
    @IBAction func buttonWasPressed(_ sender: Any) {
        button.isEnabled = false
        
        var colorSet = getUniqueColors(count: views.count + 1)
    
        UIView.animate(
            withDuration: 1.2,
            animations: {
                self.view.backgroundColor = colorSet.popFirst()
                
                for view in self.views {
                    view.backgroundColor = colorSet.popFirst()
                    self.changeCornerRadius(view: view, maxRadius: Constants.maxRadiusOfView)
                }
            },
            completion: { [weak self] _ in
                self?.button.isEnabled = true
            }
        )
    }
}
