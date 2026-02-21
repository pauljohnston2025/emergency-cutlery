import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Lang;

class EmergencyCutleryView extends WatchUi.View {
    private var _monkey as BitmapResource?;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        _monkey = WatchUi.loadResource(Rez.Drawables.MonkeyChef) as BitmapResource;
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // 1. Draw Monkey (Shifted higher to make room)
        if (_monkey != null) {
            var mX = (screenW - _monkey.getWidth()) / 2;
            var mY = (screenH - _monkey.getHeight() - screenH * 0.35) / 2;
            dc.drawBitmap(mX, mY, _monkey);
        }

        // 2. Draw Title Text
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            screenW / 2,
            screenH * 0.7,
            Graphics.FONT_MEDIUM,
            "EMERGENCY",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );

        // 3. Draw Subtitle (Orange)
        dc.setColor(0xffaa00, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            screenW / 2,
            screenH * 0.8,
            Graphics.FONT_SMALL,
            "CUTLERY",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );

        // 4. Draw Interaction Hint
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            screenW / 2,
            screenH * 0.9,
            Graphics.FONT_XTINY,
            "TAP TO START",
            Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
    }
}
