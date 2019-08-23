//
//  CTHelpViewController.swift
//  CTHelp
//
//  Created by Stewart Lynch on 6/24/19.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import MessageUI
import UIKit
import WebKit

@available(iOS 12.0, *)
public class CTHelpViewController: UIViewController, UICollectionViewDataSource,MFMailComposeViewControllerDelegate, UICollectionViewDelegate {
    
    // Colours
    var mailTintColor:UIColor?
    var bgViewColor:UIColor?
    var helpTextColor:UIColor?
    var titleColor:UIColor?
    var actionButtonBGColor:UIColor?
    var actionButtonTextColor:UIColor?
    var closeButtonBGColor:UIColor?
    var pageControlColor:UIColor?
    
    var pageControl:UILabel = {
        let pageControl = UILabel()
        pageControl.text = ""
        if #available(iOS 13.0, *) {
            pageControl.textColor = UIColor.secondaryLabel
        } else {
            pageControl.textColor = UIColor.darkGray
        }
        pageControl.font = UIFont.systemFont(ofSize: 17)
        return pageControl
    }()
    
    
    
    var currentPage: Int = 0 {
        didSet {
            let currentInt = currentPage + 1
            let remainderInt = ctHelpItem.count - currentInt
            pageControl.text = "\(String(repeating: "●", count: currentInt))\(String(repeating: "○", count: remainderInt))"
        }
    }
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView!.collectionViewLayout as! CTHelpCVFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    // Strings
    var ctString:CTString?
    var address:String!
    
    var ctHelpItem:[CTHelpItem] = []
    
    var collectionView: UICollectionView?
    var collectionLayout: CTHelpCVFlowLayout = CTHelpCVFlowLayout()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 0.5)
        setupScrollView()
        currentPage = 0
        //        setupFrame()
    }
    
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let flowLayout = collectionView?.collectionViewLayout as? CTHelpCVFlowLayout else {
            return
        }
        let cellSize =  CGSize(width: size.width  , height: 330)
        flowLayout.itemSize = cellSize
        flowLayout.invalidateLayout()
        collectionView?.reloadData()
        
    }
    
    fileprivate func setupScrollView(){
        let collectionFrame                 = CGRect(x: 0, y: 60, width: view.bounds.width, height: 350)
        
        self.collectionView                 = UICollectionView(frame: collectionFrame, collectionViewLayout: collectionLayout)
        collectionView?.register(CTHelpCVCell.self, forCellWithReuseIdentifier: "CELL")
        collectionView?.backgroundColor     = UIColor.clear
        
        collectionView?.dataSource          = self
        collectionView?.delegate            = self
        collectionView?.isPagingEnabled     = false
        collectionView?.contentInset        = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionLayout.scrollDirection    = .horizontal
        
        let itemWidth                       = view.bounds.width
        collectionLayout.itemSize           = CGSize(width: itemWidth, height: 330)
        collectionLayout.minimumLineSpacing = 0
        collectionView?.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(self.collectionView!)
        collectionView!.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth]
        
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: collectionView!.bottomAnchor, constant: 10).isActive = true
        if let color = pageControlColor {
            pageControl.textColor = color
        }
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ctHelpItem.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: CTHelpCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as? CTHelpCVCell {
            cell.delegate = self
            let item = ctHelpItem[indexPath.row]
            cell.configureView(ctHelpItem: item,
                                     bgViewColor: bgViewColor,
                                     titleColor: titleColor,
                                     helpTextColor: helpTextColor,
                                     actionButtonBGColor: actionButtonBGColor,
                                     actionButtonTextColor: actionButtonTextColor,
                                     closeButtonBGColor: closeButtonBGColor,
                                     ctString:ctString
            )

            return cell
        }
        
        return UICollectionViewCell()
    }

    public func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    public func emailDeveloper(withAddress emailAddress:String, withData data:Data?) {
        CTEmailFunctions.emailDeveloper(withAddress:emailAddress, withData: data,withStrings: ctString, mailTintColor: mailTintColor, from: self)
    }
    

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView!.collectionViewLayout as! CTHelpCVFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }

}

