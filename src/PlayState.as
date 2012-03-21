package  
{	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../media/ship1.PNG")] protected var shipImageOld:Class;
		[Embed(source = "../media/flyingbaby.png")] protected var shipImage:Class;
		[Embed(source="../media/babybarf.png")] protected var babyBarf:Class;
		private var sf:StarField = new StarField();
		private var shipLocation:int = FlxG.width / 2;
		private var ship:FlxSprite = new FlxSprite();		
		private var barf:FlxSprite = new FlxSprite();	

		private var babyRotatingForward:Boolean = false;
		private var babyRotatingReverse:Boolean = false;
		private var babyAngle:int = 0;
		
		private var babyBarfing:Boolean = false;
		private var barfAge:int = 0;
		
		private var alien1:FlxSprite = new FlxSprite();		
		
		override public function create():void
		{
			
			
			var frame:FlxSprite = new FlxSprite(4,4);
			frame.createGraphic(50,10); //White frame for the health bar
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			add(frame);
			 
			var inside:FlxSprite = new FlxSprite(5,5);
			inside.createGraphic(48,8,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			add(inside);
			 
			var bar:FlxSprite = new FlxSprite(5,5);
			bar.createGraphic(1,8,0xffff0000); //The red bar itself
			bar.scrollFactor.x = bar.scrollFactor.y = 0;
			bar.origin.x = bar.origin.y = 0; //Zero out the origin
			bar.scale.x = 48; //Fill up the health bar all the way
			add(bar);			
			bar.scale.x = 24; //Drop the health bar to half
			
			
			//add(new FlxText(0,0,100,"Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			//ship.createGraphic(20, 40, 0xff44ffff);
			ship.loadGraphic(shipImage);
			barf.loadGraphic(babyBarf);
			barf.visible = false;
			barf.x = (FlxG.width /2)-10;	
			/*
			alien1.createGraphic(10, 20, 0xff00ff00);			
			alien1.x = (FlxG.width / 2) - 5;
			alien1.y = (FlxG.height / 2) - 10;
		
			alien1.acceleration.y = 200
			*/
			ship.x = shipLocation - 10;
			ship.y = FlxG.height - 84;			
			add(sf);
			add(barf);
			//add(alien1);
			add(ship);			
		}
		
		override public function update():void
		{
			var mouseX:Number = FlxG.mouse.x;		//Get the X position of the mouse in the game world		 
			var screenX:Number = FlxG.mouse.screenX;	//Get the X position of the mouse in screen space		 
			var pressed:Boolean = FlxG.mouse.pressed();	//Check whether the mouse is currently pressed		 
			var justPressed:Boolean = FlxG.mouse.justPressed();		 
			var justReleased:Boolean = FlxG.mouse.justReleased();		 
			if (FlxG.mouse.justPressed())
			{
				var emitter:FlxEmitter = new FlxEmitter(FlxG.mouse.x,FlxG.mouse.y); //x and y of the emitter
				var particles:int = 6;
				 
				for(var i:int = 0; i < particles; i++)
				{
					var particle:FlxSprite = new FlxSprite();
					if(i < 2) {
						particle.createGraphic(2, 2, 0xffff0000);
					} else if (i < 4) {
						particle.createGraphic(2, 2, 0xff00ff00);
					} else if (i < 6) {
						particle.createGraphic(2, 2, 0xff0000ff);
					}
					emitter.add(particle);
				}
				 
				add(emitter);
				emitter.start();
			}
			
						
			if(FlxG.keys.justPressed("UP") && !babyRotatingReverse && !babyRotatingForward)
			{	
				babyRotatingForward = true;
			}
			
			if(FlxG.keys.justPressed("DOWN") && !babyRotatingReverse && !babyRotatingForward)
			{	
				babyRotatingReverse = true;
			}
			
			if(FlxG.keys.justPressed("SPACE") && !babyRotatingReverse && !babyRotatingForward)
			{	
				if(!babyBarfing) {
					barf.y = FlxG.height - 100;
					barf.x = ship.x + 20;
					barf.visible = true;
					babyBarfing = true;
				}
			}
			
			
			

			if(FlxG.keys.justPressed("LEFT"))
			{	
				shipLocation = shipLocation - 15;
				ship.x = shipLocation -5;
				sf.rotate(10);
								
			}
			if(FlxG.keys.justPressed("RIGHT"))
			{	
				shipLocation = shipLocation + 15;
				ship.x = shipLocation -5;				
				sf.rotate(-10);
			}					
			
			if (babyRotatingForward) {
				if(babyAngle != 180) {
					babyAngle += 10;
					ship.angle = babyAngle;
				} else {
					babyRotatingForward = false;
				}
			}
			
			if (babyRotatingReverse) {
				if(babyAngle != 0) {
					babyAngle -= 10;
					ship.angle = babyAngle;
				} else {
					babyRotatingReverse = false;
				}
			}
			
			if (babyBarfing) {
				if (barfAge == 16) {
					barfAge = 0;
					babyBarfing = false;
					barf.visible = false;
					barf.angle = 0;
				} else {
					barfAge++;
					barf.y = barf.y - 10;
					barf.angle += barf.angle + 15;
				}
				
			}
			//trace(mouseX + ":" + mouseY);
			super.update();
		}
	}		
}