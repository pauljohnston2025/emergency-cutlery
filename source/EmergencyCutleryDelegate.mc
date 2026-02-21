import Toybox.WatchUi;

class EmergencyCutleryDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        onSelect();
    }

    function onSelect() {
        var menu = new WatchUi.Menu();
        menu.setTitle("Select Tool");
        menu.addItem("Knife", :knife);
        menu.addItem("Fork", :fork);
        menu.addItem("Spoon", :spoon);
        
        WatchUi.pushView(menu, new EmergencyCutleryMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
}
