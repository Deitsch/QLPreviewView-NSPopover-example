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
class AppDelegate: NSObject, NSApplicationDelegate, QLPreviewPanelDataSource {

    @IBOutlet weak var window: NSWindow!
    var url: URL!

    @IBAction func showPopover(_ sender: AnyObject) {
        let popover = NSPopover()
        popover.contentViewController = ViewController()
        popover.behavior = NSPopover.Behavior.transient;
        popover.show(relativeTo: NSZeroRect, of: window.contentView!, preferredEdge: .maxX)
    }
    
    @IBAction func showPanel(_ sender: Any) {
        if QLPreviewPanel.sharedPreviewPanelExists() && QLPreviewPanel.shared().isVisible {
            QLPreviewPanel.shared().orderOut(nil)
        }
        else {
            url = Bundle.main.url(forResource: "Yosemite", withExtension: "jpg")
            guard let panel = QLPreviewPanel.shared() else { return }
            panel.dataSource = self
            panel.makeKeyAndOrderFront(nil)
        }
    }
    
    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return 1
    }

    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        return self.url as QLPreviewItem
    }

}

