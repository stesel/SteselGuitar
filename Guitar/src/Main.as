package {

import alternativa.engine3d.alternativa3d;
import alternativa.engine3d.controllers.SimpleObjectController;
import alternativa.engine3d.core.Camera3D;
import alternativa.engine3d.core.events.MouseEvent3D;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.core.View;
import alternativa.engine3d.lights.AmbientLight;
import alternativa.engine3d.lights.DirectionalLight;
import alternativa.engine3d.lights.OmniLight;
import alternativa.engine3d.lights.SpotLight;
import alternativa.engine3d.loaders.ParserA3D;
import alternativa.engine3d.loaders.ParserCollada;
import alternativa.engine3d.loaders.TexturesLoader;
import alternativa.engine3d.materials.EnvironmentMaterial;
import alternativa.engine3d.materials.FillMaterial;
import alternativa.engine3d.materials.StandardMaterial;
import alternativa.engine3d.materials.TextureMaterial;
import alternativa.engine3d.materials.VertexLightTextureMaterial;
import alternativa.engine3d.objects.Mesh;
import alternativa.engine3d.objects.Skin;
import alternativa.engine3d.objects.SkyBox;
import alternativa.engine3d.primitives.Box;
import alternativa.engine3d.primitives.GeoSphere;
import alternativa.engine3d.resources.BitmapTextureResource;
import alternativa.engine3d.resources.ExternalTextureResource;
import alternativa.engine3d.shadows.DirectionalLightShadow;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.StageDisplayState;
import flash.events.FullScreenEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.navigateToURL;
import flash.net.URLRequest;
import flash.sampler.NewObjectSample;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.clearTimeout;
import flash.utils.setInterval;
import flash.utils.setTimeout;
//import sky.SkyBoxDemo;
import string.String1;

import flash.display.Sprite;
import flash.display.Stage3D;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.display3D.Context3DRenderMode;
import flash.events.Event;


[Frame(factoryClass = "Preloader")]

public class Main extends Sprite {
	
	//[Embed(source="guitar.a3d", mimeType="application/octet-stream")]
	//[Embed(source = "guitar.a3d", mimeType = "application/octet-stream")]
	//[Embed(source="Guirar_1S.DAE", mimeType="application/octet-stream")]
	//private const Model:Class;
	
	//[Embed(source="../demoexample/level.DAE", mimeType="application/octet-stream")]
	//[Embed(source = "Guirar_2.DAE", mimeType = "application/octet-stream")]
	[Embed(source="guitar.A3D", mimeType="application/octet-stream")]
	static private const GuitarModel:Class;

	[Embed(source = "GuitarDif.png")] static private const guitar_t_d:Class;
	private var guitar_d:BitmapTextureResource = new BitmapTextureResource(new guitar_t_d().bitmapData);
	[Embed(source="GuitarNorm.png")] static private const guitar_t_n:Class;
	private var guitar_n:BitmapTextureResource = new BitmapTextureResource(new guitar_t_n().bitmapData);
	
	[Embed(source="GuitarSpec.png")] static private const guitar_t_s:Class;
	private var guitar_s:BitmapTextureResource = new BitmapTextureResource(new guitar_t_s().bitmapData);
	
	//[Embed(source = "stringDif.png")] static private const string_t_d:Class;
	//private var string_d:BitmapTextureResource = new BitmapTextureResource(new string_t_d().bitmapData);
	
	
	
	[Embed(source="images/stesel.png")]
	private const Button_2:Class;
	
	[Embed(source = "resetButton.png")]
	private const Button_1:Class;
	
	[Embed(source="fullScrButton.png")]
	private const Button_3:Class;
	
	//[Embed(source="bSky/left.jpg")] static private const left_t_c:Class;
	//private var left_t:BitmapTextureResource = new BitmapTextureResource(new left_t_c().bitmapData);
	//[Embed(source="bSky/right.jpg")] static private const right_t_c:Class;
	//private var right_t:BitmapTextureResource = new BitmapTextureResource(new right_t_c().bitmapData);
	//[Embed(source="bSky/top.jpg")] static private const top_t_c:Class;
	//private var top_t:BitmapTextureResource = new BitmapTextureResource(new top_t_c().bitmapData);
	//[Embed(source="bSky/bottom.jpg")] static private const bottom_t_c:Class;
	//private var bottom_t:BitmapTextureResource = new BitmapTextureResource(new bottom_t_c().bitmapData);
	//[Embed(source="bSky/front.jpg")] static private const front_t_c:Class;
	//private var front_t:BitmapTextureResource = new BitmapTextureResource(new front_t_c().bitmapData);
	//[Embed(source="bSky/back.jpg")] static private const back_t_c:Class;
	//private var back_t:BitmapTextureResource = new BitmapTextureResource(new back_t_c().bitmapData);
	
	/////////
	[Embed(source = "bSky/ceiling.png")] static private const ceiling_t_c:Class;
	private var ceiling_t:BitmapTextureResource = new BitmapTextureResource(new ceiling_t_c().bitmapData);
	//
	[Embed(source = "bSky/floor.png")] static private const floor_t_c:Class;
	private var floor_t:BitmapTextureResource = new BitmapTextureResource(new floor_t_c().bitmapData);
	//
	[Embed(source="bSky/wall.png")] static private const wall_t_c:Class;
	private var wall_t:BitmapTextureResource = new BitmapTextureResource(new wall_t_c().bitmapData);
	
	[Embed(source="bSky/wall_door.png")] static private const wallDoor_t_c:Class;
	private var wallDoor_t:BitmapTextureResource = new BitmapTextureResource(new wallDoor_t_c().bitmapData);
	
	[Embed(source="bSky/wall_win.png")] static private const wallWin_t_c:Class;
	private var wallWin_t:BitmapTextureResource = new BitmapTextureResource(new wallWin_t_c().bitmapData);
	
	
	////////
	//Sound
	//
	
	
	[Embed(source="sounds/1.mp3")] static private const sSt1:Class;
	private var soundSt1 : Sound = (new sSt1) as Sound;
	private var soundSt1Channel:SoundChannel;
	
	[Embed(source="sounds/2.mp3")] static private const sSt2:Class;
	private var soundSt2 : Sound = (new sSt2) as Sound;
	private var soundSt2Channel:SoundChannel;
	
	[Embed(source="sounds/3.mp3")] static private const sSt3:Class;
	private var soundSt3 : Sound = (new sSt3) as Sound;
	private var soundSt3Channel:SoundChannel;
	
	[Embed(source="sounds/4.mp3")] static private const sSt4:Class;
	private var soundSt4 : Sound = (new sSt4) as Sound;
	private var soundSt4Channel:SoundChannel;
	
	[Embed(source="sounds/5.mp3")] static private const sSt5:Class;
	private var soundSt5 : Sound = (new sSt5) as Sound;
	private var soundSt5Channel:SoundChannel;
	
	[Embed(source="sounds/6.mp3")] static private const sSt6:Class;
	private var soundSt6 : Sound = (new sSt6) as Sound;
	private var soundSt6Channel:SoundChannel;
	
	
	
	
	
	
	
	

    private const RESOURCE_LIMIT_ERROR_ID:int = 3691;
	
	
	private var guitarModel:Mesh;
	
	private var string1:Mesh;
	private var string2:Mesh;
	private var string3:Mesh;
	private var string4:Mesh;
	private var string5:Mesh;
	private var string6:Mesh;

	private var stage3D:Stage3D;
	private var scene:Object3D;
	private var camera:Camera3D;
	private var freeCamera:Camera3D;
	private var view:View;
	private var controller:SimpleObjectController;
	private var cameraContainer:Object3D = new Object3D();
	private var targetContainer:Object3D = new Object3D();
	private var lightContainer:Object3D = new Object3D();
	
	private var skyBox:SkyBox;
	
	
	private var sphere:GeoSphere;
	
	private var lightColor:uint;
	
	
		private var light:DirectionalLight;
		private var ambientLight:AmbientLight;
		private var omniLight:OmniLight;
		private var spotLight:SpotLight;
		private var directionalLight:DirectionalLight;
		private var directionalLight2:DirectionalLight;
		private var directionalLight3:DirectionalLight;
		private var shadow:DirectionalLightShadow;
		
		
		private var cube: Box;
		
		
		
		private var standartMat: StandardMaterial;
		
		//private var enMaterial:EnvironmentMaterial;
		
		
		//private var vexMaterial: VertexLightTextureMaterial;
		
		
		
		private var left:Boolean;
		private var up:Boolean;
		private var right:Boolean;
		private var down:Boolean;
		
		
		private var resetButton: MovieClip;
		private var steselButton: MovieClip;
		private var fullScrButton:MovieClip;
		
		private var delay:Number = 150; // delay before calling myDelayedFunction
        private var intervalId:uint;
        private var lightIntervalId:uint;
	
		//private var guitar: Mesh;
		private var level:Mesh;
		private var freeController:SimpleObjectController;
		private var freeFlag:Boolean = false;
		
		private var freeText: TextField = new TextField(); 
		private var helpText: TextField = new TextField(); 
		private var format:TextFormat = new TextFormat();
		private var fullScreen:Boolean;
		
		
		//private var stringQuietMat:StandardMaterial;
		
		
		
		private var stCover1:Mesh;
		private var stCover2:Mesh;
		private var stCover3:Mesh;
		private var stCover4:Mesh;
		private var stCover5:Mesh;
		private var stCover6:Mesh;
		private var stime:Number= 0;
		
		
		
		private var st1:String1;
		private var st2:String1;
		private var st3:String1;
		private var st4:String1;
		private var st5:String1;
		private var st6:String1;
		private var friction:Number = 1;
		private var friction1:Number;
		private var st1vibr:Boolean;
		private var friction2:Number;
		private var friction3:Number;
		private var friction4:Number;
		private var friction5:Number;
		private var friction6:Number;
		private var st2vibr:Boolean;
		private var st3vibr:Boolean;
		private var st4vibr:Boolean;
		private var st5vibr:Boolean;
		private var st6vibr:Boolean;
		private var intervalId2:uint;
		
	public function Main() {
				//super();
		if (stage) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
				
			//stage.showDefaultContextMenu = true;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.tabChildren = false;
			//stage.stageFocusRect = false;
			//stage.focus = stage;
			//stage.quality = "high";
				
				
		
		

	}
	
	private function init(e:Event = null):void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		//stage.showDefaultContextMenu = true;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.tabChildren = false;
			//stage.stageFocusRect = false;
			//stage.focus = stage;
			//stage.quality = "high";
				
				
		//set initial stage properties (optional)
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.stageFocusRect = false;
		stage.quality = StageQuality.HIGH;
		stage.addEventListener(Event.RESIZE, onStageResize);

		//create view
		view = new View(stage.stageWidth, stage.stageHeight, false, 0x696969, 1, 4);
		addChild(view);
		
		
		//create camera
		camera = new Camera3D(0.01, 10000);
		//set camera properties
		camera.x = 0;
		camera.y = 0;
		camera.z = -350;
		camera.rotationX = 0;
		camera.rotationY = 0;
		camera.rotationZ = 0;
		camera.nearClipping = 1;
		camera.farClipping = 1363.3422088623047;
		//camera.debug = true;
		//set view to camera
		camera.view = view;
		//camera.view = new View(stage.stageWidth, stage.stageHeight, false, 0x000000, 0, 4);
	
		//add performance diagram to display list
		//addChild(camera.diagram);
		camera.view.hideLogo();
		

		//create root object
		scene = new Object3D();
		//add camera so it can render scene content
		cameraContainer.rotationZ = 100;
		cameraContainer.rotationX = 100;
		cameraContainer.rotationY = 100;
		
		cameraContainer.addChild(camera);
		//cameraContainer.rotationX = 9 * Math.PI;
		
		
		////////////
		freeCamera = new Camera3D(0.01, 10000);
		freeCamera.view = view;
		//addChild(freeCamera.view);
		
		//freeCamera.x = 0;
		//freeCamera.y = 0;
		//freeCamera.z = 0;
		
		freeCamera.rotationX = -90*Math.PI/180;
		freeCamera.y = -400;
		freeCamera.z = 0;
		freeCamera.nearClipping = 1;
		freeCamera.farClipping = 5363.3422088623047;
		//freeCamera.rotationZ = 100;
		//freeCamera.rotationX = 100;
		//freeCamera.rotationY = 100;
		//
		
		freeCamera.view.hideLogo();
		
		scene.addChild(freeCamera);
		
		
		//cameraContainer.rotationY = 180;
		
		
		scene.addChild(targetContainer);
		scene.addChild(lightContainer);
		targetContainer.addChild(cameraContainer);
			
		
		
		lightColor = Math.random() * 0xFFFFFF;
		/////
		directionalLight = new DirectionalLight(0xffffff); // Конструктор принимает один аргумент - цвет света
			directionalLight.z = -300;
			directionalLight.intensity = 0.6;      				//настраиваем интенсивность света
			directionalLight.lookAt(0, 0, 0);
			//scene.addChild(directionalLight);		
			cameraContainer.addChild(directionalLight);		
			//
			directionalLight2 = new DirectionalLight(lightColor); // Конструктор принимает один аргумент - цвет света
			directionalLight2.x = -300;
			directionalLight2.z = 0;
			directionalLight2.intensity = 0.3;      				//настраиваем интенсивность света
			directionalLight2.lookAt(0, 0, 0);
			//scene.addChild(directionalLight2);
			lightContainer.addChild(directionalLight2);
			

			directionalLight3 = new DirectionalLight(0xB0FC12); // Конструктор принимает один аргумент - цвет света
			directionalLight3.x = 300;
			directionalLight3.z = -30;
			directionalLight3.intensity = 0.3;      				//настраиваем интенсивность света
			directionalLight3.lookAt(0, 0, 0);
			//scene.addChild(directionalLight3);
			//lightContainer.addChild(directionalLight3);
			
			
			
			ambientLight = new AmbientLight(0xFFFFFF); //Создаем AmbientLight. Конструктор принимает один аргумент - цвет света
			ambientLight.intensity = 0.3; //настраиваем интенсивность света
			ambientLight.z = 100;
			scene.addChild(ambientLight);
			
			

			
			/////
			//cube = new Box(100, 100, 100);
			//cube.setMaterialToAllSurfaces(new TextureMaterial(guitar_d));
			//scene.addChild(cube);
			
		//Sky
		skyBox = new SkyBox(
				1100, 					//Размер по всем трём осям
				new TextureMaterial(wallWin_t),		//Материал для левой стороны
				new TextureMaterial(wallDoor_t), 		//Материал для правой стороны
				new TextureMaterial(wall_t), 		//Материал для задней стороны
				new TextureMaterial(wall_t), 		//Материал для передней стороны
				new TextureMaterial(floor_t), 		//Материал для нижней стороны
				new TextureMaterial(ceiling_t), 	//Материал для верхней стороны
				0.007);					//Отступ от краёв в текстурных координатах
		       	scene.addChild(skyBox);
		//skyBox.x = skyBox.y = skyBox.z = 0;
		
		/////////
		
		
		
		///////////////
		sphere = new GeoSphere(15, 3, false, new FillMaterial(lightColor, 0.85));
		
		sphere.x = -150;
		sphere.z = 300;
		lightContainer.addChild(sphere);
		
		omniLight = new OmniLight(lightColor, 10, 30);
		omniLight.x = -150;
		omniLight.z = 300;
		lightContainer.addChild(omniLight);
		
		
		//receive stage3D
		stage3D = stage.stage3Ds[0];
		stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);
		stage3D.requestContext3D(Context3DRenderMode.AUTO);
		
		camera.view.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);	
				//create simple controller to control camera
		stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
		stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
		
		
		
		//setInterval(changeLightColor, 7000);
		
		//////
		shadow = new DirectionalLightShadow(1000, 1000, -500, 500, 512, 2);
		shadow.biasMultiplier = 0.8;
		//shadow.addCaster(sphere);
		//shadow.addCaster(skyBox);
		directionalLight.shadow = shadow;
		//directionalLight2.shadow = shadow;
		///////
		//////////////
		
		
		
        format.font = "Arial";
        format.color = 0x7FFF00;
		format.bold = true;
        format.size = 14;
		//format.align = "center";
		freeText.multiline = false;
		
		freeText.defaultTextFormat = format;
		freeText.selectable = false;
		
		freeText.text = "Free Camera";
		freeText.x = 2;
		
		freeText.antiAliasType = "advanced";
        //freeText.autoSize = "center";
		freeText.multiline = false;
		freeText.wordWrap = false;
		freeText.selectable = false;
		freeText.autoSize = TextFieldAutoSize.LEFT;
		freeText.backgroundColor = 0x555555;
		
		
		
		
		helpText.alpha = 0.9;
		helpText.multiline = true;
		
		helpText.defaultTextFormat = format;
		helpText.selectable = false;
		
		helpText.text = "Click on the strings. 'F' - Free Camera, 'TAB' - FPS.";
		
		helpText.antiAliasType = "advanced";
        //freeText.autoSize = "center";
		helpText.multiline = false;
		helpText.wordWrap = false;
		helpText.selectable = false;
		helpText.autoSize = TextFieldAutoSize.LEFT;
		helpText.backgroundColor = 0x555555;
		
		helpText.y = stage.stageHeight - helpText.height;
		
		stage.addChild(helpText);
		
		
	}

	private function onStageResize(event:Event):void {
		//resize view to stage size
		view.width = stage.stageWidth;
		view.height = stage.stageHeight;
		
		
		resetButton.x = stage.stageWidth - resetButton.width;
		//resetButton.rotation = 9;
		
		steselButton.x = stage.stageWidth - steselButton.width;
		steselButton.y = stage.stageHeight - steselButton.height;
		
		helpText.y = stage.stageHeight - helpText.height;
		
		if (fullScrButton != null)
		{
			fullScrButton.x = stage.stageWidth - fullScrButton.width;
			fullScrButton.y = 1.2*resetButton.height;
		}
		
	}

	private function onContext3DCreate(e:Event):void {
		stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContext3DCreate);

		//create model and apply textures
		setupModel();

		controller = new SimpleObjectController(stage, cameraContainer, 300);	// добавляем контроллер объектов и привязываем его к контейнеру камеры
			controller.lookAtXYZ(targetContainer.x, targetContainer.y, targetContainer.z);
			controller.unbindAll();
			cameraContainer.rotationX = Math.PI * 270 / 180;
			controller.updateObjectTransform();
			
			
			/////////////
			//freeController = new SimpleObjectController(stage, freeCamera, 300, 2);
			//freeController.unbindAll();
			//freeController.lookAtXYZ(0, 0, 0);
			//freeController.updateObjectTransform();
			
			////////////
			
			
			
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		////////////////
		var user:VKUser = new VKUser();	
		this.stage.addChild(user);
				
				
		var butBit:Bitmap = new Button_1();
		
		//butBit = new Button_1();
		resetButton = new MovieClip();
		resetButton.buttonMode = true;
		resetButton.addChild(butBit);
		//resetButton = (new Button_1) as MovieClip;
		resetButton.x = stage.stageWidth - resetButton.width;
		//resetButton.x = stage.stageHeight - resetButton.height;
		this.stage.addChild(resetButton);
		//trace(resetButton.width);
		resetButton.addEventListener(MouseEvent.CLICK, mouseClick);
		
		
		
		
		var butBit1:Bitmap = new Button_2();
		
		
		steselButton = new MovieClip();
		steselButton.buttonMode = true;
		
		
		steselButton.addChild(butBit1);
		steselButton.x = stage.stageWidth - steselButton.width;
		steselButton.y = stage.stageHeight - steselButton.height;
		
		this.stage.addChild(steselButton);
		
		steselButton.addEventListener(MouseEvent.CLICK, mouseClickStesel);
			
		var butBit2:Bitmap = new Button_3();
		fullScrButton = new MovieClip();
		fullScrButton.buttonMode = true;
		fullScrButton.addChild(butBit2);
		fullScrButton.x = stage.stageWidth - fullScrButton.width;
		fullScrButton.y = 1.2*resetButton.height;
		fullScrButton.addEventListener(MouseEvent.CLICK, fullScrButton_click);
		stage.addChild(fullScrButton);
		
		
		
		
		
		
	}
	
	private function fullScrButton_click(e:MouseEvent):void 
	{
		if(fullScrButton.scaleX ==1)
			fullScrButton.scaleX = fullScrButton.scaleY = 0.9;
		else
			clearTimeout(intervalId2);
			
		intervalId2 = setTimeout(resetScaleFullScr, delay);
		
		onFullScreen();
	}
	
	private function resetScaleFullScr():void 
	{
		fullScrButton.scaleX = fullScrButton.scaleY = 1;
	}

	private function onEnterFrame(e:Event):void {
		//apply changes made by controller to camera
		lightContainer.rotationZ += 0.02;
		
		
		//string1.rotationZ += 90/180*Math.PI;
		
		controller.update();
		//render scene
		if(!freeFlag)
		camera.render(stage3D);
		else
		freeCamera.render(stage3D);
		
		/////////////////
		if (left)
			{
				targetContainer.x -= 5;
			}
		if (up)
			{
				targetContainer.z += 5;
			}
		if (right)
			{
				targetContainer.x += 5;
			}
		if (down)
			{
				targetContainer.z -= 5;
			}
		
			//var st1:String1;
			//st1 = scene.getChildByName("st1") as String1;
		if (st1vibr)
		{
			if (st1 != null) st1.update(stime,friction1);
				
			stime +=2;
			friction1 -= 0.03;
			if (friction1 <= 0)
			{
				st1vibr = false;
				st1.restore();
				//trace("res");
			}
			//trace("res2");
		}
		
		if (st2vibr)
		{
			if (st2 != null) st2.update(stime,friction2);
				
			stime +=1.9;
			friction2 -= 0.03;
			if (friction2 <= 0)
			{
				st2vibr = false;
				st2.restore();
				//trace("res");
			}
			//trace("res2");
		}
		
		if (st3vibr)
		{
			if (st3 != null) st3.update(stime,friction3);
				
			stime +=1.8;
			friction3 -= 0.03;
			if (friction3 <= 0)
			{
				st3vibr = false;
				st3.restore();
				//trace("res");
			}
			//trace("res2");
		}
		
		if (st4vibr)
		{
			if (st4 != null) st4.update(stime,friction4);
				
			stime +=1.7;
			friction4 -= 0.03;
			if (friction4 <= 0)
			{
				st4vibr = false;
				st4.restore();
				//trace("res");
			}
			//trace("res2");
		}
		
		if (st5vibr)
		{
			if (st5 != null) st5.update(stime,friction5);
				
			stime +=1.6;
			friction5 -= 0.03;
			if (friction5 <= 0)
			{
				st5vibr = false;
				st5.restore();
				//trace("res");
			}
			//trace("res2");
		}
		
		if (st6vibr)
		{
			if (st6 != null) st6.update(stime,friction6);
				
			stime +=1.5;
			friction6 -= 0.03;
			if (friction6 <= 0)
			{
				st6vibr = false;
				st6.restore();
				//trace("res");
			}
			//trace("res2");
		}
	}

	private function setupModel():void 
	{
		//create parser and parse data
		//var parser:ParserA3D = new ParserA3D();
		//parser.parse(new Model());
		//
		//guitarModel = new Mesh(); //создаем Mesh.   
		//scene.addChild(guitarModel); //добавляем в главный контейнер
 		//
		//enMaterial = new EnvironmentMaterial(guitar_d);
		//enMaterial
		//
		//
		//vexMaterial = new VertexLightTextureMaterial(guitar_d, guitar_d);
		//
		//
		//
		//
		//
		standartMat = new StandardMaterial(guitar_d, guitar_n);
		standartMat.specularPower = 0.3;
		standartMat.glossiness = 50;
		//standartMat.
		
		
		//stringOverMat = new StandardMaterial(guitar_d, guitar_n);
		//stringOverMat.specularPower = 3;
		//stringOverMat.glossiness = 2;
		
		//stringQuietMat = new StandardMaterial(guitar_d, guitar_n);
		//stringQuietMat.specularPower = 0.3;
		//stringQuietMat.glossiness = 50;
		//var textureLoader:TexturesLoader = new TexturesLoader(stage3D.context3D);
		//var texturesLoader:TexturesLoader = new TexturesLoader(stage3D.context3D);
			//texturesLoader.loadResources(guitar_d);
		//guitar_d.upload(stage3D.context3D);
		//
			//for each (var object:Object3D in parser.objects){ //перебираем массив objects
				//if (object is Mesh){
					//var mesh:Mesh = Mesh(object); //преобразуем в Mesh
					//
					//mesh.setMaterialToAllSurfaces(new FillMaterial(Math.random() * 0xFFFFFF, 0.5)); //просто «красим»
					//mesh.setMaterialToAllSurfaces(standartMat); //просто «красим»
					//mesh.setMaterialToAllSurfaces(standartMat); //просто «красим»
					//guitarModel.addChild(mesh); //добавляем в контейнер для машины
				//}
			//}
			//
			//var boxx: Box = new Box(100, 100, 100);
			//boxx.setMaterialToAllSurfaces(standartMat);
			//boxx.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(boxx);
			
			
			
		
				
				
				///////////////
		// Parser of character
			// Парсер персонажа
			
			// Parser of level
			// Парсер уровня
			//var guitarParser:ParserCollada = new ParserCollada();
			//guitarParser.parse(XML(new GuitarModel()));
			
			var guitarParser:ParserA3D = new ParserA3D(); //создаем парсер
			
			guitarParser.parse(new GuitarModel()) //разбираем модель	
			
			
			guitarModel = guitarParser.getObjectByName("guitar") as Mesh;
			
			//string1 = guitarParser.getObjectByName("string_1") as Mesh;
			//string2 = guitarParser.getObjectByName("string_2") as Mesh;
			//string3 = guitarParser.getObjectByName("string_3") as Mesh;
			//string4 = guitarParser.getObjectByName("string_4") as Mesh;
			//string5 = guitarParser.getObjectByName("string_5") as Mesh;
			//string6 = guitarParser.getObjectByName("string_6") as Mesh;
			
			stCover1 = guitarParser.getObjectByName("scover1") as Mesh;
			stCover2 = guitarParser.getObjectByName("scover2") as Mesh;
			stCover3 = guitarParser.getObjectByName("scover3") as Mesh;
			stCover4 = guitarParser.getObjectByName("scover4") as Mesh;
			stCover5 = guitarParser.getObjectByName("scover5") as Mesh;
			stCover6 = guitarParser.getObjectByName("scover6") as Mesh;
			
			//var levelMaterial:TextureMaterial = new TextureMaterial(guitar_d);
			guitarModel.setMaterialToAllSurfaces(standartMat);
			scene.addChild(guitarModel);
			//
			//string1.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(string1);
			//
			//string2.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(string2);
			//
			//string3.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(string3);
			//
			//string4.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(string4);
			//
			//string5.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(string5);
			//
			//string6.setMaterialToAllSurfaces(standartMat);
			//scene.addChild(string6);
			
			//stCover1.setMaterialToAllSurfaces(standartMat);
			scene.addChild(stCover1);
			scene.addChild(stCover2);
			scene.addChild(stCover3);
			scene.addChild(stCover4);
			scene.addChild(stCover5);
			scene.addChild(stCover6);
			
			
			
			
			
			
			stCover1.addEventListener(MouseEvent3D.CLICK, onString1Click);
			
			stCover2.addEventListener(MouseEvent3D.CLICK, onString2Click);
			//
			stCover3.addEventListener(MouseEvent3D.CLICK, onString3Click);
			//
			stCover4.addEventListener(MouseEvent3D.CLICK, onString4Click);
			//
			stCover5.addEventListener(MouseEvent3D.CLICK, onString5Click);
			//
			stCover6.addEventListener(MouseEvent3D.CLICK, onString6Click);
			//
			//
			stCover1.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver1);
			stCover1.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut1);
			
			stCover2.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver2);
			stCover2.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut2);
			
			stCover3.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver3);
			stCover3.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut3);
			
			stCover4.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver4);
			stCover4.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut4);
			
			stCover5.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver5);
			stCover5.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut5);
			
			stCover6.addEventListener(MouseEvent3D.MOUSE_OVER, onMouseOver6);
			stCover6.addEventListener(MouseEvent3D.MOUSE_OUT, onMouseOut6);
			
			
			
			
			
			
			//var stString: Vector.<String1> = new Vector.<String1>();
			
			st1 = new String1(0, 90, new FillMaterial(0XCACACA),0.05);
			//st1.geometry.upload(stage3D.context3D);
			st1.x = 8.1;
			st1.y = -4.63;
			st1.z = 131.65;
			st1.rotationX = -0.51 * Math.PI / 180;
			st1.rotationY = -0.75 * Math.PI / 180;
			//st1.setMaterialToAllSurfaces(stringQuietMat);
			scene.addChild(st1);
			
			
			st2 = new String1(0, 90, new FillMaterial(0XCACACA),0.063);
			//st2.geometry.upload(stage3D.context3D);
			st2.x = 5.4;
			st2.y = -4.63;
			st2.z = 131.65;
			st2.rotationX = -0.51 * Math.PI / 180;
			st2.rotationY = -0.45 * Math.PI / 180;
			scene.addChild(st2);
			//st1.setMaterialToAllSurfaces()
			
			st3 = new String1(0, 90, new FillMaterial(0XCACACA),0.076);
			//st3.geometry.upload(stage3D.context3D);
			st3.x = 2.4;
			st3.y = -4.63;
			st3.z = 131.65;
			st3.rotationX = -0.51 * Math.PI / 180;
			st3.rotationY = -0.15 * Math.PI / 180;
			scene.addChild(st3);
			
			
			st4 = new String1(0, 90, new FillMaterial(0XCACACA),0.09);
			//st4.geometry.upload(stage3D.context3D);
			st4.x = -0.6;
			st4.y = -4.66;
			st4.z = 131.65;
			st4.rotationX = -0.51 * Math.PI / 180;
			st4.rotationY = 0.17 * Math.PI / 180;
			scene.addChild(st4);
			
			st5 = new String1(0, 90, new FillMaterial(0XCACACA),0.103);
			//st5.geometry.upload(stage3D.context3D);
			st5.x = -3.5;
			st5.y = -4.68;
			st5.z = 131.65;
			st5.rotationX = -0.51 * Math.PI / 180;
			st5.rotationY = 0.47 * Math.PI / 180;
			scene.addChild(st5);
			
			st6 = new String1(0, 90, new FillMaterial(0XCACACA),0.116);
			//st6.geometry.upload(stage3D.context3D);
			st6.x = -6.4;
			st6.y = -4.7;
			st6.z = 131.65;
			st6.rotationX = -0.51 * Math.PI / 180;
			st6.rotationY = 0.78 * Math.PI / 180;
			scene.addChild(st6);
			// Upload
			//guitar_d.upload(stage3D.context3D);
			//guitar_n.upload(stage3D.context3D);
			//level.geometry.upload(stage3D.context3D);	
			shadow.addCaster(guitarModel);
			shadow.addCaster(st1);
			shadow.addCaster(st2);
			
			
			
			for each (var resource:Resource in scene.getResources(true))
			{
				resource.upload(stage3D.context3D);	
			}
		
	
	}
	
	
	
	private function onMouseOver1(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = true;
		//string1.setMaterialToAllSurfaces(stringOverMat);
		st1.setMaterialToAllSurfaces(new FillMaterial(0XFFFFFF));
		
	}
	
	private function onMouseOut1(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = false;
		st1.setMaterialToAllSurfaces(new FillMaterial(0XCACACA));
		//string1.
	}
	
	
	
	private function onString1Click(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		
		soundSt1Channel = soundSt1.play();
		
		friction1 = 1;
		st1vibr = true;
		
	}
		
	private function onMouseOver2(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = true;
		//string2.setMaterialToAllSurfaces(stringOverMat);
		st2.setMaterialToAllSurfaces(new FillMaterial(0XFFFFFF));
		
	}
	
	private function onMouseOut2(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = false;
		//string2.setMaterialToAllSurfaces(standartMat);
		st2.setMaterialToAllSurfaces(new FillMaterial(0XCACACA));
	}
	
	
	
	private function onString2Click(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		
		soundSt2Channel = soundSt2.play();
		
		friction2 = 1;
		st2vibr = true;
	}
	
			
	private function onMouseOver3(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = true;
		st3.setMaterialToAllSurfaces(new FillMaterial(0XFFFFFF));
		//string3.setMaterialToAllSurfaces(stringOverMat);
	}
	
	private function onMouseOut3(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = false;
		st3.setMaterialToAllSurfaces(new FillMaterial(0XCACACA));
		//string3.setMaterialToAllSurfaces(standartMat);
	}
	
	
	
	private function onString3Click(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		
		soundSt3Channel = soundSt3.play();
		friction3 = 1;
		st3vibr = true;
	}
	
	
	private function onMouseOver4(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = true;
		//string4.setMaterialToAllSurfaces(stringOverMat);
		st4.setMaterialToAllSurfaces(new FillMaterial(0XFFFFFF));
	}
	
	private function onMouseOut4(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = false;
		//string4.setMaterialToAllSurfaces(standartMat);
		st4.setMaterialToAllSurfaces(new FillMaterial(0XCACACA));
	}
	
	
	
	private function onString4Click(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		
		soundSt4Channel = soundSt4.play();
		friction4 = 1;
		st4vibr = true;
	}
		
	private function onMouseOver5(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = true;
		//string5.setMaterialToAllSurfaces(stringOverMat);
		st5.setMaterialToAllSurfaces(new FillMaterial(0XFFFFFF));
	}
	
	private function onMouseOut5(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = false;
		//string5.setMaterialToAllSurfaces(standartMat);
		st5.setMaterialToAllSurfaces(new FillMaterial(0XCACACA));
	}
	
	
	
	private function onString5Click(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		
		soundSt5Channel = soundSt5.play();
		
		friction5 = 1;
		st5vibr = true;
		
	}
		
	private function onMouseOver6(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = true;
		//string6.setMaterialToAllSurfaces(stringOverMat);
		st6.setMaterialToAllSurfaces(new FillMaterial(0XFFFFFF));
	}
	
	private function onMouseOut6(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		object.useHandCursor = false;
		//string6.setMaterialToAllSurfaces(standartMat);
		st6.setMaterialToAllSurfaces(new FillMaterial(0XCACACA));
	}
	
	
	
	private function onString6Click(e:MouseEvent3D):void 
	{
		var object:Object3D = e.target as Object3D;
		
		soundSt6Channel = soundSt6.play();
		friction6 = 1;
		st6vibr = true;
	}
	
	
	
	
	
	
	


	private function onMouseWheel(e:MouseEvent):void {
			if ((e.delta < 0) && camera.z > -800) 
				camera.z -= 10;
			if ((e.delta > 0)&& camera.z < -10 ) 
				camera.z += 10;
				
		}
	private function key_down(e:KeyboardEvent):void
	{	
		
		if(e.keyCode == 37)
			{
				left = true;
			}
		if(e.keyCode == 38)
			{
				up = true;
			}
		if(e.keyCode == 39)	
			{
				right = true;
			}
		if(e.keyCode == 40)
			{
				down = true;
			}
		
		if(e.keyCode == 9)
		{
			if (!freeFlag)
			{
				if (!stage.contains(camera.diagram))
				{
					addChild(camera.diagram);
					resetButton.y = camera.diagram.height;
					fullScrButton.y = camera.diagram.height + 1.2 * resetButton.height;
				}
				else
				{
					removeChild(camera.diagram);
					resetButton.y = 0;
					fullScrButton.y = 1.2 * resetButton.height;
				}
			}
			else
			{
				if (!stage.contains(freeCamera.diagram))
				{
					addChild(freeCamera.diagram);
					resetButton.y = freeCamera.diagram.height;
					fullScrButton.y = camera.diagram.height + 1.2 * resetButton.height;
				}
				else
				{
					removeChild(freeCamera.diagram);
					resetButton.y = 0;
					fullScrButton.y = 1.2 * resetButton.height;
				}
			}
			
		}
		
		
		if (e.keyCode == 70)
		{
			/////////////
			targetContainer.x = targetContainer.y = targetContainer.z = 0;
			
			camera.x = 0;
			camera.y = 0;
			camera.z = -350;
			camera.rotationX = 0;
			camera.rotationY = 0;
			camera.rotationZ = 0;
				
				
				
			cameraContainer.x = 0;
			cameraContainer.y = 0;
			cameraContainer.z = 0;
			cameraContainer.rotationX = Math.PI * 270 / 180;
			cameraContainer.rotationY = 0;
			cameraContainer.rotationZ = 0;
				
				
			freeCamera.rotationZ = 0
			freeCamera.rotationY = 0;
			freeCamera.rotationX = -90*Math.PI/180;
			freeCamera.y = -400;
			freeCamera.z = 0;
			freeCamera.x= 0;
				
				
				
			controller.updateObjectTransform();
			//////////////////
			
			
			
			if (!freeFlag)
			{
				if (stage.contains(camera.diagram))
				{
					removeChild(camera.diagram);
					addChild(freeCamera.diagram);
					
				}
				
				stage.addChild(freeText);
				freeFlag = true;
				controller = new SimpleObjectController(stage, freeCamera, 300);	// добавляем контроллер объектов и привязываем его к контейнеру камеры
				//controller.lookAtXYZ(targetContainer.x, targetContainer.y, targetContainer.z);
				//controller.unbindAll();
				//cameraContainer.rotationX = Math.PI * 270 / 180;
				controller.updateObjectTransform();
			}
			else
			{
				if (stage.contains(freeCamera.diagram))
				{
					addChild(camera.diagram);
					removeChild(freeCamera.diagram);
					
				}
				stage.removeChild(freeText);
				freeFlag = false;
				controller = new SimpleObjectController(stage, cameraContainer, 300);	// добавляем контроллер объектов и привязываем его к контейнеру камеры
				controller.lookAtXYZ(targetContainer.x, targetContainer.y, targetContainer.z);
				controller.unbindAll();
				cameraContainer.rotationX = Math.PI * 270 / 180;
				controller.updateObjectTransform();
				
			}
			
			
		}
		if (e.keyCode == 82)
		mouseClick(null);
		
		
		if (e.keyCode == 123) 
		{
			if (!fullScreen)
			onFullScreen();
		}
		
		//if (e.keyCode == 27)
		//{
			//if(fullScreen)
			//offFullScreen();
		//}
		
	}
	
	private function key_up(e:KeyboardEvent):void
	{
	
		if(e.keyCode == 37)
			{
				left = false;
			}
		if(e.keyCode == 38)
			{
				up = false;
			}
		if(e.keyCode == 39)	
			{
				right = false;
			}
		if(e.keyCode == 40)
			{
				down = false;
			}
		//if (e.keyCode == 40)
		//{
			//
		//}
	}
	
	private function mouseClick(e:MouseEvent):void
	{
		
		if(resetButton.scaleX ==1)
			resetButton.scaleX = resetButton.scaleY = 0.9;
		else
			clearTimeout(intervalId);
			
		intervalId = setTimeout(resetScale, delay);
		
		changeLightColor();
		
		
		targetContainer.x = targetContainer.y = targetContainer.z = 0;
		
		camera.x = 0;
		camera.y = 0;
		camera.z = -350;
		camera.rotationX = 0;
		camera.rotationY = 0;
		camera.rotationZ = 0;
		
		
			
		cameraContainer.x = 0;
		cameraContainer.y = 0;
		cameraContainer.z = 0;
		cameraContainer.rotationX = Math.PI * 270 / 180;
		cameraContainer.rotationY = 0;
		cameraContainer.rotationZ = 0;
		
		
		freeCamera.rotationZ = 0
		freeCamera.rotationY = 0;
		freeCamera.rotationX = -90*Math.PI/180;
		freeCamera.y = -400;
		freeCamera.z = 0;
		freeCamera.x= 0;
		
		
		
		controller.updateObjectTransform();
		//controller.
		
	}
	private function resetScale():void
	{
		resetButton.scaleX = resetButton.scaleY = 1;
	}
	
	private function changeLightColor():void
	{
		lightColor = Math.random() * 0xFFFFFF;
		directionalLight2.color = lightColor;
		sphere.setMaterialToAllSurfaces(new FillMaterial(lightColor, 0.85));
	}
	
	private function onFullScreen(): void
	{
		stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		fullScreen = true;
		
		stage.removeChild(helpText);
		stage.removeChild(steselButton);
		
		
		stage.addEventListener(FullScreenEvent.FULL_SCREEN, offFullScreen);
		
		stage.removeChild(fullScrButton);
		
	}
	
	private function offFullScreen(e:FullScreenEvent): void
	{
		stage.displayState = StageDisplayState.NORMAL;
		fullScreen = false;
		
		stage.addChild(helpText);
		
		stage.addChild(steselButton);
		
		stage.addChild(fullScrButton);
		
		stage.removeEventListener(FullScreenEvent.FULL_SCREEN, offFullScreen);
		
	}
	
	
	
	private function mouseClickStesel(e:MouseEvent):void
	{
		navigateToURL(new URLRequest("http://vk.com/stesel23"));
	}
}
}