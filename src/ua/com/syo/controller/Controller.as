package ua.com.syo.controller {
	import flash.events.Event;
	
	import ua.com.syo.model.Model;
	import ua.com.syo.view.UIManager;
	
	public class Controller	{
		
		/**
		 * Singleton
		 */
		private static var _instance:Controller;

		public static function get instance():Controller {
			if (_instance == null) {
				_instance = new Controller();
			}
			return _instance;
		}
		
		public function init():void {
			UIManager.instance.init();
			Model.instance.init();
			Model.instance.addEventListener(Event.INIT, modelInitHandler);
			//UIManager.instance.videoArea.setSize();
		}
		
		private function modelInitHandler(event:Event):void {
			UIManager.instance.showStartImage();
		}
	}
}