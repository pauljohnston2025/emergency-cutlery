import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

class EasterEggDelegate extends WatchUi.BehaviorDelegate {
    private var _clickCount as Number = 0;
    private var _lastClickTime as Number = 0;
    private const TIMEOUT_MS as Number = 1000; // 1 second window between clicks

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        return onSelect();
    }

    function onSelect() as Boolean {
        var currentTime = System.getTimer();

        // Check if the click is within the timeout window
        if (currentTime - _lastClickTime < TIMEOUT_MS) {
            _clickCount++;
        } else {
            _clickCount = 1; // Reset to 1 if they took too long
        }

        _lastClickTime = currentTime;

        if (visitedKnife && visitedFork && visitedSpoon && _clickCount >= 5) {
            _clickCount = 0; // Reset
            WatchUi.pushView(
                new ToolGeneratingView(:egg),
                new WatchUi.BehaviorDelegate(),
                WatchUi.SLIDE_IMMEDIATE
            );
            return true;
        }

        if (_clickCount >= 5) {
            _clickCount = 0; // Reset
            WatchUi.pushView(
                new ToolGeneratingView(:spork),
                new WatchUi.BehaviorDelegate(),
                WatchUi.SLIDE_IMMEDIATE
            );
            return true;
        }

        return false;
    }
}
