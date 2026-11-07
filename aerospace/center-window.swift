// Centre the focused window on the monitor it's on, via the Accessibility API.
// Compiled on first use by center-if-floating.sh (osascript + System Events took ~250ms).
import AppKit

func attr(_ el: AXUIElement, _ name: String) -> CFTypeRef? {
    var ref: CFTypeRef?
    return AXUIElementCopyAttributeValue(el, name as CFString, &ref) == .success ? ref : nil
}
// System-wide kAXFocusedApplicationAttribute fails (-25204) here, so ask NSWorkspace instead
guard let pid = NSWorkspace.shared.frontmostApplication?.processIdentifier,
      let winRef = attr(AXUIElementCreateApplication(pid), kAXFocusedWindowAttribute), CFGetTypeID(winRef) == AXUIElementGetTypeID(),
      let posRef = attr(winRef as! AXUIElement, kAXPositionAttribute),
      let sizeRef = attr(winRef as! AXUIElement, kAXSizeAttribute)
else { exit(1) }
let win = winRef as! AXUIElement

var pos = CGPoint.zero, size = CGSize.zero
AXValueGetValue(posRef as! AXValue, .cgPoint, &pos)
AXValueGetValue(sizeRef as! AXValue, .cgSize, &size)
let centre = CGPoint(x: pos.x + size.width / 2, y: pos.y + size.height / 2)

// NSScreen is bottom-left origin; AX positions are top-left origin
let mainH = NSScreen.screens[0].frame.height
for screen in NSScreen.screens {
    let f = screen.visibleFrame
    let r = CGRect(x: f.minX, y: mainH - f.maxY, width: f.width, height: f.height)
    guard r.contains(centre) else { continue }
    var p = CGPoint(x: (r.minX + max(0, (r.width - size.width) / 2)).rounded(),
                    y: (r.minY + max(0, (r.height - size.height) / 2)).rounded())
    AXUIElementSetAttributeValue(win, kAXPositionAttribute as CFString, AXValueCreate(.cgPoint, &p)!)
    break
}
