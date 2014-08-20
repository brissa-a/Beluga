package beluga.core.api;

import haxe.web.Dispatch;
import haxe.Session;

import beluga.core.macro.ModuleLoader;

class BelugaApi {

	public var moduleList = new Map < String, Dispatch -> Void >() ;
	
	public function new() 
	{		
	}

	public function doDefault(moduleName : String, d : Dispatch) {
		//Init session
		Session.start();
		if (moduleList.exists(moduleName)) {
			moduleList[moduleName](d);
		} else {
			trace("Module " + moduleName + " not found");
		}
		Session.close();
	}

}