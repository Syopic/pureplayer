package ua.com.syo.view {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class UIManager extends Sprite {
		
		/**
		 * Singleton
		 */
		private static var _instance:UIManager;

		public static function get instance():UIManager {
			if (_instance == null) {
				_instance = new UIManager();
			}
			return _instance;
		}
		
		public var videoArea:VideoArea;
		
		public function init():void {
			videoArea = new VideoArea(this);
			var c:ControlPanel = new ControlPanel();
			var cc:DisplayObject = addChild(c);
			cc.x = 5;
			cc.y = 305;
		}
		
	}
}