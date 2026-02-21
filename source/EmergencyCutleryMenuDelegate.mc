import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class EmergencyCutleryMenuDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        // Find the main view and tell it which tool to "generate"
        var view = new ToolGeneratingView(item);
        WatchUi.switchToView(view, new EasterEggDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}