package 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GradientGlowFilter;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import vk.APIConnection;
	import vk.events.*
	
	/**
	 * ...
	 * @author Leonid Trofimchuk
	 */
	public class VKUser extends Sprite 
	{
		private var result_tf:TextField;
		private var _gradientGlow:GradientGlowFilter;
		private var textFormat:TextFormat;
		
		public var api_id:Number;
        public var viewer_id:Number;
        public var sid:String;
        public var secret:String;
		
		public function VKUser():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_gradientGlow = new GradientGlowFilter();
			_gradientGlow.distance = 0; 
			_gradientGlow.colors = [0x000000, 0x000000];
			_gradientGlow.alphas = [0, 1]; 
			_gradientGlow.ratios = [0, 255]; 
			_gradientGlow.blurX = 4; 
			_gradientGlow.blurY = 4; 
			_gradientGlow.strength = 2;
			_gradientGlow.quality = BitmapFilterQuality.LOW;
			_gradientGlow.type = BitmapFilterType.OUTER;
			
			textFormat = new TextFormat();
			textFormat.size = 16;
			textFormat.color = 0x00ffff;
			
			result_tf = new TextField();
			result_tf.filters[_gradientGlow];
			result_tf.selectable = false;
			result_tf.defaultTextFormat = textFormat;
			result_tf.filters[_gradientGlow];
			result_tf.autoSize = TextFieldAutoSize.LEFT;
			addChild(result_tf);
			
			var flashVars:Object;
			
			flashVars = stage.loaderInfo.parameters as Object;
			
			api_id = flashVars['api_id'];
			viewer_id = flashVars['viewer_id'];
			sid = flashVars['sid'];
			secret = flashVars['secret'];
			
			CONFIG::local
			{
				api_id = 2945479;
				viewer_id = 4530688;
				sid = "8c7be1f017586596b6a2420ab8e81a473df59e695172e92fdd8eb5b5740781cc48e5d4d0ef271be999c7c";
				secret = "d8b80fd7f7";
			}
			
			var VK:APIConnection = new APIConnection(flashVars);
			VK.api("getProfiles", { uids: flashVars["viewer_id"], fields:'photo_big' }, onProfileLoaded, onError);
			
		}
		
		private function onProfileLoaded(data:Object):void 
		{
			result_tf.visible = false;
			result_tf.htmlText = data[0]["first_name"] + " " + data[0]["last_name"] +  "\n" + "Guitar Level: " + getRandomUserLevel(data[0]['uid']);
			
			var loader: Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			loader.load(new URLRequest(data[0]['photo_big']));
			result_tf.htmlText = data[0]["first_name"] + " " + data[0]["last_name"] +  "\n" + "Guitar Level: " + getRandomUserLevel(data[0]['uid']);
			
		}
		
		private function loader_complete(e:Event):void 
		{
			var loader:Loader = e.currentTarget.loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_complete);
			loader.x = 3;
			loader.y = 3;
			loader.scaleX = loader.scaleY = 0.5; 
			loader.filters = [_gradientGlow];
			result_tf.filters = [_gradientGlow];
			addChild(loader);
			result_tf.y = loader.y + loader.height + 4;
			result_tf.visible = true;
		}
		
		private function getRandomUserLevel(id:Number):String
		{
			var i:int = Math.round(Math.random() * 3);
			var level:String;
			
			switch (i)
			{
				case 1:
					level = "Noob";
					break;
				case 2:
					level = "middle"
					break;
				case 3:
					level = "Master";
					break;
				default:
					level = "Noob";
					break;
			}
			
			if (id == 4530688)
			{
				level = "Master";
			}
			
			return level;
			
		}
		
		private function onError(data:Object):void 
		{
			result_tf.htmlText = new Error(data["error_msg"]).getStackTrace();
		}
		
		private function checkData():void 
		{
			trace(secret);
		}
		
	}
	
}