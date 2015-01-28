// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package ;

import beluga.Beluga;
import php.Web;
import beluga.module.testmodule.TestModule;

class Main {
    public static var beluga : Beluga;

    static function main() {
        var beluga = Beluga.getInstance();
        var testModule = beluga.getModuleInstance(TestModule);
        beluga.handleRequest();
        Sys.print("<link rel='stylesheet' href='/beluga/css/beluga.css'");
        Sys.print(testModule.widgets.helloWorld.render());
        beluga.cleanup();
    }
}