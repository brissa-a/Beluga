package beluga.module.testmodule;

// beluga core
import beluga.module.Module;
import beluga.I18n;

// beluga mods
import beluga.module.testmodule.TestModuleWidgets;
import beluga.module.testmodule.TestModuleTriggers;
import beluga.module.testmodule.api.TestModuleApi;

@:Css("/beluga/module/testmodule/view/test.css")
class TestModule extends Module {
    public var triggers = new TestModuleTriggers();
    public var widgets: TestModuleWidgets;

	public var i18n = BelugaI18n.loadI18nFolder("/beluga/module/testmodule/locale/");

    public function new() {
        super();
    }

    override public function initialize(beluga : Beluga) {
        this.widgets = new TestModuleWidgets();
        beluga.api.register("testModule", new TestModuleApi(beluga, this));
    }
}