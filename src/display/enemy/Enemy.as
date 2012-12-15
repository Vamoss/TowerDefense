﻿package display.enemy{	//imports	import core.Level;		import flash.display.MovieClip;	import flash.display.Shape;	import flash.display.Sprite;	import flash.events.*;

	//defining the class	public class Enemy extends MovieClip{		private var _root:TowerDefense;		public var xSpeed:int;//how fast it's going horizontally		public var ySpeed:int;//how fast it's going vertically		public var maxSpeed:int = 3;//how fast it can possibly go		public var accelSpeed:Number = 1;//deaccelarate when hit by Ice bullet 		public var health:int;		public var level:int;//this will be set to the number passed in				private var startHealth:int;		private var healthBar:Shape = new Shape();				public function Enemy(root:TowerDefense, code:int){			_root = root;						this.addChild(healthBar);						this.addEventListener(Event.ADDED, beginClass);			this.addEventListener(Event.ENTER_FRAME, update);						level = code;//set the level to the value passed in for use in other functions		}				private function beginClass(e:Event):void{						startHealth = health = level*5;						//checking what the start direction is			if(_root.game.level.startDir == Level.U){//if it's starting up				this.y = 300;//set the y value off the field				this.x = _root.game.level.startCoord;//make the x value where it should be				this.xSpeed = 0;//make it not move horizontally				this.ySpeed = -maxSpeed;//make it move upwards			} else if(_root.game.level.startDir == Level.R){//and so on for other directions				this.x = -25;				this.y = _root.game.level.startCoord;				this.xSpeed = maxSpeed;				this.ySpeed = 0;			} else if(_root.game.level.startDir == Level.D){				this.y = -25;				this.x = _root.game.level.startCoord;				this.xSpeed = 0;				this.ySpeed = maxSpeed;			} else if(_root.game.level.startDir == Level.L){				this.x = 550;				this.y = _root.game.level.startCoord;				this.xSpeed = -maxSpeed;				this.ySpeed = 0;			}						//draw the actual enemy, it's just a red ball			this.graphics.beginFill(0xFF0000);			this.graphics.drawCircle(_root.gridScaleHalf,_root.gridScaleHalf,5);			this.graphics.endFill();		}				private function update(e:Event):void{			//move it based on x and y value			this.x += xSpeed * accelSpeed;			this.y += ySpeed * accelSpeed;						if(accelSpeed<1){				accelSpeed+=.01;			}						//checking what direction it goes when finishing the path			if(_root.game.level.finDir == Level.U){//if it finishes at the top				if(this.y <= -25){//if the y value is too high					destroyThis();//then remove this guy from the field					_root.game.lives --;//take away a life				}			} else if(_root.game.level.finDir == Level.R){//and so on for other directions				if(this.x >= 550){					destroyThis();										_root.game.lives --;				}			} else if(_root.game.level.finDir == Level.D){				if(this.y >= 300){					destroyThis();					_root.game.lives --;				}			} else if(_root.game.level.startDir == Level.L){				if(this.x <= 0){					destroyThis();					_root.game.lives --;				}			}						//remove this from stage when game is over			if(_root.game.isOver){				destroyThis();			}						//destroy this if health is equal to or below 0			if(health <= 0){				destroyThis();				_root.game.money += 5*level;			}else if(health < startHealth){				//update health bar				healthBar.graphics.clear();				healthBar.graphics.lineStyle(1, 0x00FF00);				healthBar.graphics.beginFill(0x0000FF);				healthBar.graphics.drawRect(0, 0, 25, 5);				healthBar.graphics.lineStyle(0);				healthBar.graphics.beginFill(0xFF0000);				healthBar.graphics.drawRect(1, 1, 23*health/startHealth, 3);				healthBar.graphics.endFill();			}		}		public function destroyThis():void{			//this function will make it easier to remove this from stage			this.removeEventListener(Event.ENTER_FRAME, update);			if(this.parent) if(this.parent.contains(this)) this.parent.removeChild(this);			_root.game.level.enemiesLeft --;		}	}}
