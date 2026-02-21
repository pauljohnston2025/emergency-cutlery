import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Lang;

var visitedKnife as Boolean = false;
var visitedFork as Boolean = false;
var visitedSpoon as Boolean = false;

class ToolGeneratingView extends WatchUi.View {
    private var _tool as Symbol;
    private var _progress as Number = 0;
    private var _timer as Timer.Timer;
    private var _toolBitmap as BitmapResource?;

    function initialize(tool as Symbol) {
        View.initialize();
        _tool = tool;
        _timer = new Timer.Timer();
    }

    function onShow() as Void {
        _timer.start(method(:updateProgress), 100, true);

        if (_tool == :knife) {
            _toolBitmap = WatchUi.loadResource(Rez.Drawables.KnifeImg) as BitmapResource?;
            visitedKnife = true;
        } else if (_tool == :fork) {
            _toolBitmap = WatchUi.loadResource(Rez.Drawables.ForkImg) as BitmapResource?;
            visitedFork = true;
        } else if (_tool == :spoon) {
            _toolBitmap = WatchUi.loadResource(Rez.Drawables.SpoonImg) as BitmapResource?;
            visitedSpoon = true;
        } else if (_tool == :spork) {
            _toolBitmap = WatchUi.loadResource(Rez.Drawables.SporkImg) as BitmapResource?;
        } else if (_tool == :egg) {
            _toolBitmap = WatchUi.loadResource(Rez.Drawables.EggImg) as BitmapResource?;
        }
    }

    function updateProgress() as Void {
        _progress += 5;
        if (_progress >= 100) {
            _progress = 101;
            _timer.stop();
        }
        WatchUi.requestUpdate();
    }

    // Inside ToolGeneratingView.mc

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var screenW = dc.getWidth();
        var screenH = dc.getHeight();

        // Determine the proper name string
        var toolName = "";
        if (_tool == :knife) {
            toolName = "KNIFE";
        } else if (_tool == :fork) {
            toolName = "FORK";
        } else if (_tool == :spoon) {
            toolName = "SPOON";
        } else if (_tool == :spork) {
            toolName = "SPORK";
        } else if (_tool == :egg) {
            toolName = "EGG";
        }

        if (_progress <= 100) {
            // LOADING STATE
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                screenW / 2,
                screenH * 0.25,
                Graphics.FONT_SMALL,
                "FORGING " + toolName,
                Graphics.TEXT_JUSTIFY_CENTER
            );

            dc.drawRectangle(screenW / 4, screenH / 2, screenW / 2, 15);
            dc.setColor(0xffaa00, Graphics.COLOR_TRANSPARENT);
            dc.fillRectangle(screenW / 4, screenH / 2, (screenW / 2) * (_progress / 100.0), 15);

            var flavorText = [
                "Aligning Pixels...",
                "Sharpening Tines...",
                "Polishing Silver...",
                "Calibrating Weight...",
            ];
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                screenW / 2,
                screenH * 0.8,
                Graphics.FONT_XTINY,
                flavorText[(_progress / 5) % 4],
                Graphics.TEXT_JUSTIFY_CENTER
            );
        } else {
            // READY STATE
            if (_toolBitmap != null) {
                var bX = (screenW - _toolBitmap.getWidth()) / 2;
                var bY = (screenH - _toolBitmap.getHeight() - screenH * 0.35) / 2;
                dc.drawBitmap(bX, bY, _toolBitmap);
            }

            // Title - Move to 60%
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                screenW / 2,
                screenH * 0.7,
                Graphics.FONT_MEDIUM,
                "READY FOR USE",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );

            dc.setColor(0xffaa00, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                screenW / 2,
                screenH * 0.8,
                Graphics.FONT_SMALL,
                toolName,
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );

            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(
                screenW / 2,
                screenH * 0.9,
                Graphics.FONT_XTINY,
                "(Do not lick screen)",
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );

            if (_tool == :spork) {
                dc.setColor(0xffd700, Graphics.COLOR_TRANSPARENT); // Gold
                dc.setPenWidth(6);
                dc.drawArc(
                    screenW / 2,
                    screenH / 2,
                    screenW / 2,
                    Graphics.ARC_COUNTER_CLOCKWISE,
                    0,
                    360
                );
            }
        }
    }
}
