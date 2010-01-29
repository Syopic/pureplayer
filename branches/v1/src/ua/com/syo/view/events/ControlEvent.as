package ua.com.syo.view.events {
	import flash.events.Event;

	public class ControlEvent extends Event {
		
		public var actionType:String;
		
		public static var CONTROL_ACTION:String = "controlAction";
		public static var PLAY_ACTION:String = "playAction";
		public static var PAUSE_ACTION:String = "pauseAction"; 
		
		public function ControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
	}
}