//
//  AppDelegate.swift
//  QuickLookPopover
//
//  Created by Josh Parnham on 15/6/18.
//  Copyright © 2018 Josh Parnham. All rights reserved.
//

import Cocoa
import Quartz

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet var  popover: NSPopover!
    
    let url: URL! = Bundle.main.url(forResource: "Yosemite", withExtension: "jpg")
//    let url: URL! = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/David_von_Michelangelo.jpg/313px-David_von_Michelangelo.jpg")!
//    let url: URL! = URL(fileURLWithPath: "/Users/.../catbage.png")
    
    @IBAction func showPopover(_ sender: AnyObject) {
        popover = NSPopover()
        popover.contentViewController = ViewController()
        popover.behavior = NSPopover.Behavior.transient;
        popover.show(relativeTo: NSZeroRect, of: window.contentView!, preferredEdge: .maxX)
    }
    
    @IBAction func showPanel(_ sender: Any) {
        guard let panel = QLPreviewPanel.shared() else { return }
        
        if QLPreviewPanel.sharedPreviewPanelExists() && panel.isVisible {
            panel.orderOut(nil)
        }
        else {
            panel.makeKeyAndOrderFront(nil)
        }
    }
}

extension AppDelegate: QLPreviewPanelDataSource {
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return 1
    }

    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return url as QLPreviewItem
    }
    
    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        return true
    }
    
    override func beginPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.dataSource = self
        panel.delegate = self
    }

    override func endPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.dataSource = nil
        panel.delegate = nil
    }
}
