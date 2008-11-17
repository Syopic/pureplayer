package ua.com.syo.view {
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ua.com.syo.data.CurrentData;
	import ua.com.syo.data.Globals;

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
		public var controlPanel:ControlPanel;
		public var startImage:StartImage;
		
		public function init():void {
			videoArea = new VideoArea(this);
			videoArea.setSize(Globals.stageWidth, Globals.stageHeight - 40);
			controlPanel = new ControlPanel();
			addChild(controlPanel);
		}
		
		public function showStartImage():void {
			startImage = new StartImage(CurrentData.instance.getStartImage());
			addChild(startImage);
			startImage.setSize(Globals.stageWidth, Globals.stageHeight - 40);
			startImage.addEventListener(Event.ACTIVATE, bigPlayButtonClicked);
		}
		
		private function bigPlayButtonClicked(event:Event):void {
			playVideo();
		}
		
		public function playVideo():void {
			if (contains(startImage)) {
				removeChild(startImage);
			}
		}
		
		public function updateSlider():void {
			
		}
		
	}
}