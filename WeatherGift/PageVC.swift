//
//  PageVC.swift
//  WeatherGift
//
//  Created by Joseph Marasco on 10/14/19.
//  Copyright © 2019 Joseph Marasco. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {

    var currentPage = 0
    var locationsArray = ["Local City", "Chestnut Hill, MA", "Accra, Ghana", "Sydney, Australia", "Uglich, Russia"]
    
    var pageControl: UIPageControl!
    var listButton: UIButton!
    var barButtonWidth: CGFloat = 44
    var barButtonHeight: CGFloat = 44
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        
        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configurePageControl()
        configureListButton()
    }
    
    // MARK:- UI Configuration Methods
    func configurePageControl() {
        let pageControlHeight: CGFloat = barButtonHeight
        let pageControlWidth: CGFloat = view.frame.height - (barButtonWidth * 2)
        
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        pageControl = UIPageControl(frame: CGRect(x: ((view.frame.width - pageControlWidth)/2), y: (safeHeight - pageControlHeight), width: pageControlWidth, height: pageControlHeight))
        
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = locationsArray.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlPressed), for: .touchUpInside)
        
        
        view.addSubview(pageControl)
    }
    
    func configureListButton(){
        let safeHeight = view.frame.height - view.safeAreaInsets.bottom
        
        listButton = UIButton(frame: CGRect(x: view.frame.width - barButtonWidth, y: safeHeight - barButtonHeight, width: barButtonWidth, height: barButtonHeight))
        listButton.setImage(UIImage(named: "listButton"), for: .normal)
        listButton.setImage(UIImage(named: "listButton-highlighted"), for: .highlighted)
        listButton.addTarget(self, action: #selector(segueToLocationVC), for: .touchUpInside)
        view.addSubview(listButton)
    }
    
    @objc func segueToLocationVC() {
        print("Hey, you clicked me")
    }
    
    // MARK:- Create View Controller for PageViewController
    func createDetailVC(forPage page: Int) -> DetalVC {
        currentPage = min(max(0, page), locationsArray.count - 1)
        let detailVC = storyboard!.instantiateViewController(withIdentifier: "DetalVC") as! DetalVC
        detailVC.locationsArray = locationsArray
        detailVC.currentPage = currentPage
        return detailVC
    }
}

extension PageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetalVC{
            if currentViewController.currentPage < locationsArray.count - 1 {
                return createDetailVC(forPage: currentPage + 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? DetalVC {
            if currentViewController.currentPage > 0 {
                return createDetailVC(forPage: currentPage - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?[0] as? DetalVC {
            pageControl.currentPage = currentViewController.currentPage
        }
    }
    
    @objc func pageControlPressed() {
        if let currentViewController = self.viewControllers?[0] as? DetalVC {
            currentPage = currentViewController.currentPage
        }
        if pageControl.currentPage < currentPage {
            setViewControllers([createDetailVC(forPage: pageControl.currentPage)], direction: .reverse, animated: true, completion: nil)
        } else if pageControl.currentPage > currentPage {
            setViewControllers([createDetailVC(forPage: pageControl.currentPage)], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
}

