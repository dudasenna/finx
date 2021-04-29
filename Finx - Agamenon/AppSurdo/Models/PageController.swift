//
//  PageController.swift
//  AppSurdo
//
//  Created by Jéssica Amaral on 21/04/21.
//  Copyright © 2021 Luis Pereira. All rights reserved.
//

import Foundation
import UIKit

extension PageControlScenesViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let nextPage = pageViews.firstIndex(of: pendingViewControllers.first!) else {
            return
        }
        
        pageDots.currentPage = nextPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vCIndex = pageViews.firstIndex(of: viewController) else {
            return nil
        }
        
        var prevIndex = -1
        
        if vCIndex == 0 {
            prevIndex = pageViews.count - 1
        } else {
            prevIndex = vCIndex - 1
        }
        
        return pageViews[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vCIndex = pageViews.firstIndex(of: viewController) else {
            return nil
        }
        
        var nextIndex = -1
        
        if vCIndex == pageViews.count - 1 {
            nextIndex = 0
        } else {
            nextIndex = vCIndex + 1
        }
        
        return pageViews[nextIndex]
    }
    
    
}
