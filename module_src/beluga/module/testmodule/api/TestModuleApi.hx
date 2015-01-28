package beluga.module.testmodule.api;

import haxe.web.Dispatch;

import beluga.Beluga;
import beluga.widget.Widget;

import beluga.module.testmodule.TestModule;

class TestModuleApi {
	public var beluga : Beluga;
    public var module : TestModule;

    public function new(beluga: Beluga, module: TestModule) {
        this.beluga = beluga;
        this.module = module;
    }

    public function doDefault() {
        this.module.triggers.defaultPage.dispatch();
    }
}