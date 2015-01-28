package beluga.module.testmodule.widget;

import beluga.Beluga;
import beluga.I18n;
import beluga.widget.MttWidget;
import beluga.widget.Layout;
import beluga.module.testmodule.TestModule;

class TestModuleHelloWorld extends MttWidget<TestModule> {
    var module: TestModule;

    public function new (?layout : Layout) {
        if(layout == null) layout = Layout.newFromPath("beluga/module/testmodule/view/tpl/TestModuleHelloWorld.mtt");
        super(TestModule, layout);
        i18n = BelugaI18n.loadI18nFolder("/beluga/module/testmodule/view/locale/", mod.i18n);
    }

    override private function getContext() {
        var context = {
        }
        return context;
    }
}
