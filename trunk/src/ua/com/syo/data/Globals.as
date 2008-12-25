package ua.com.syo.data {
	public class Globals {
		
		public static var stageWidth:int = 400;
		public static var stageHeight:int = 340;
		
		public static var controlBarHeight:int = 30;
		
		public static var playlistUrl:String;
		
		public static function setFlashVars(value:Object):void {
			playlistUrl = value["playlist"] || "playlist.xml";
		}
		
	}
}