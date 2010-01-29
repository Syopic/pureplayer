package ua.com.syo.controller {
	import ua.com.syo.model.Model;
	import ua.com.syo.view.UIManager;
	import flash.events.Event;
	
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
			Model.instance.init();
			Model.instance.addEventListener(Event.INIT, modelInitHandler);
			//UIManager.instance.videoArea.setSize();
		}
		
		private function modelInitHandler(event:Event):void {
			UIManager.instance.init();
			UIManager.instance.showStartImage();
		}
	}
}