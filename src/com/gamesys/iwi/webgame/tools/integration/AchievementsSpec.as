package com.gamesys.iwi.webgame.tools.integration
{
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;

	public class AchievementsSpec extends DragableContent
	{
		private static const gamespec_keys:Array = [
			{key:"ACHIEVEMENT_TYPE",defaultValue:""},	
			{key:"REQUIREMENTS",defaultValue:""},	
			{key:"GAMESKIN",defaultValue:""},	
			{key:"ISTROPHY",defaultValue:"FALSE"},	
			{key:"NAME",defaultValue:""},	
			{key:"DESCRIPTION",defaultValue:""},	
			{key:"BONUS_COINS",defaultValue:0},	
			{key:"BONUS_COUNT",defaultValue:0},	
			{key:"REFERENCE_INDEX",defaultValue:""},	
			{key:"REFERENCE_DESCRIPTION",defaultValue:""},	
			{key:"ACHIEVEMENT_CATEGORY",defaultValue:""},	
			{key:"ACHIEVEMENT_CATEGORY_SORT",defaultValue:""},	
			{key:"NOTES",defaultValue:""},	
			{key:"IS_HIDDEN",defaultValue:"FALSE"},	
			{key:"IS_REGISTERED",defaultValue:"FALSE"},	
			{key:"ACHIEVABLE_FROM",defaultValue:""},	
			{key:"ACHIEVABLE_TO",defaultValue:""}
		];
		
		
		public static const CSV : String = "csv";

		public static const TSV : String = "tsv";

		private var _achievementsArray : Array = [];

		private var _inputFormat : String = "csv";

		private var _separator : String = ",";

		private var _extention:String = "csv";
		
		private var alertShown : Boolean;
		
		public var gameSkin:String;
		
		private static var _instance:AchievementsSpec;
		
		public function get extention():String
		{
			return _extention;
		}

		public static function getInstance( view : UIComponent = null):AchievementsSpec
		{
			if(!_instance)
			{
				_instance = new AchievementsSpec(view);
			}
			return _instance
		}
		
		public static function getNewAchievementItem():Object
		{
			var item:Object = {};
			
			for each (var def:Object in gamespec_keys) 
			{
				item[def.key] = def.defaultValue;
			}
			
			return item;
		}
		
		public function get achievementsArray() : Array
		{
			return _achievementsArray;
		}

		protected function set inputFormat( value : String ) : void
		{
			_inputFormat = value;
			_separator = ( value == CSV ) ? "," : "	";
		}


		public function AchievementsSpec( view : UIComponent = null)
		{
			super( view );
		}

		override protected function isValidateFileFormat( extention : String ) : Boolean
		{
			inputFormat = extention;
			_extention = extention;
			return ( extention == CSV || extention == TSV );
		}

		override protected function readSourceFile() : void
		{
			var fileStream : FileStream = new FileStream();
			fileStream.open( _currentFile, FileMode.READ );
			_outputContent = fileStream.readUTFBytes( fileStream.bytesAvailable );
			_achievementsArray = parseAchievements( _outputContent );
			
			fileStream.close();
		}
		
		public function saveSpec(arr:Array = null):void
		{
			if(arr)
			{
				_achievementsArray = arr;
			}
			
			if(_achievementsArray)
			{
				_outputContent = serialiseAchievements(_achievementsArray);
			}
			else
			{
				Alert.show("error:_achievementsArray is still null")
			}
			if(_currentFile)
			{
				var output:Output = new Output();
				output.write2File(_outputContent,_currentFile);
				Alert.show("Game spec file has been updated succesfully.","all good");
			}
		}
		
		public function getSeperateAchievement():Array
		{
			var achievementKeyValuePairs:Array = [];
			for( var i : int = 0; i < _achievementsArray.length; i++ )
			{
				var item:Object = _achievementsArray[i];
				var keyValuePair:Object = {};
				
				keyValuePair.key = item["ACHIEVEMENT_TYPE"];
				keyValuePair.value = item["NAME"] + "\n" + item["DESCRIPTION"];
				
				achievementKeyValuePairs.push(keyValuePair);
			}
			
			return achievementKeyValuePairs;
		}
		
		public function getAchievementsBySlots() : Object
		{
			var achievementBySlotSkinsMap : Object = {};
			
			for( var i : int = 0; i < _achievementsArray.length; i++ )
			{
				var item:Object = _achievementsArray[i];
				var slot : String = item["GAMESKIN"];
				if(slot != "" && slot != null)
				{
					var achievements : Object = achievementBySlotSkinsMap[slot];
					if(!achievements)
					{
						achievements = {};
						achievementBySlotSkinsMap[slot] = achievements;
					}
					var key : String = item["ACHIEVEMENT_TYPE"];
					achievements[key+".title"] = item["NAME"];
					achievements[key+".desc"] = item["DESCRIPTION"];
				}
			}
			return achievementBySlotSkinsMap;
		}
		
		private function serialiseAchievements(_achievementsArray:Array):String
		{
			var result:String = "";
			for( var i : int = 0; i < _achievementsArray.length; i++ )
			{
				var item:Object = _achievementsArray[i];
				
				for (var j:int = 0; j < gamespec_keys.length; j++) 
				{
					var key:String = gamespec_keys[j].key;
					var value:* = "";
					if(item.hasOwnProperty(key))
					{
						value = item[key];
					}
					result += (value + _separator);
				}
				result = result.substr(0,result.length - _separator.length);
				
				if(i < _achievementsArray.length - 1)
				{
					result += "\n";
				}
			}
			return result;
		}
		
		private function parseAchievements( str : String ) : Array
		{
			const targetXML : XML = <con></con>;
			const originalStrs : Array = str.split( "\n" );

			if( originalStrs.length == 0 )
			{
				trace( "patten dosent match \n" );
			}

			var achievements:Array = [];
			for( var i : int = 0; i < originalStrs.length; i++ )
			{
				var rowStr : String = originalStrs[ i ].toString();
				var properties : Array = rowStr.split( _separator );
				
				if(properties && properties.length > 1){
					var newItem:Object = getNewAchievementItem();
					for (var j:int = 0; j < gamespec_keys.length; j++) 
					{
						if(j < properties.length)
						{
							var key:String = gamespec_keys[j].key;
							var value:* = properties[j];
							if(key == "GAMESKIN")
							{
								gameSkin = value
							}
							newItem[key] = value;
						}
					}
					achievements.push(newItem);
				}				
			}

			return achievements;
		}

	}
}