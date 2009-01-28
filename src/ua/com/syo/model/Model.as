package ua.com.syo.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import ua.com.syo.data.CurrentData;
	import ua.com.syo.data.Globals;
	
	public class Model extends EventDispatcher {
		
		/**
		 * Singleton
		 */
		private static var _instance:Model;

		public static function get instance():Model {
			if (_instance == null) {
				_instance = new Model();
			}
			return _instance;
		}
		
		public var itemCollection:Dictionary = new Dictionary(true);
		
		//private var playlistXML:XML;
		
		public function init():void {
			loadPlaylist(Globals.playlistUrl);
		}
		
		private function loadPlaylist(url:String):void {
			var loader:URLLoader = new URLLoader();
		    loader.dataFormat = URLLoaderDataFormat.TEXT;
		    loader.addEventListener(Event.COMPLETE, playlistLoadedHandler);
		    loader.load(new URLRequest(url));
		    
		    CurrentData.instance.addEventListener(Event.COMPLETE, initComplete);
		}
		
		private function playlistLoadedHandler(event:Event):void {
			//itemCollection
			parsePlayList(XML(event.currentTarget.data));
		}
		
		private function parsePlayList(xml:XML):void {
			CurrentData.instance.rootURL = xml.@root;
			
			var itemsLength:int = xml.child("item").length();
			
			CurrentData.instance.fillFirstItem( new VideoItem(xml.child("item")[0]));
			for (var i:int = 1; i < itemsLength; i++) {
				var item:VideoItem = new VideoItem(xml.child("item")[i]);
				itemCollection[item.id] = item;
			}
		}
		
		private function initComplete(event:Event):void {
			dispatchEvent(new Event(Event.INIT));
		}

	}
}