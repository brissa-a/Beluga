// Copyright 2014 The Beluga Project Developers. See the LICENCE.md
// file at the top-level directory of this distribution and at
// http://haxebeluga.github.io/licence.html.
//
// Licensed under the MIT License.
// This file may not be copied, modified, or distributed
// except according to those terms.

package beluga.module.market.model;

import sys.db.Object;
import sys.db.Types;

@:id(id)
@:table("beluga_mar_product")
class Product extends Object {
    public var id: SId;
    public var stock: SInt;
    public var name: STinyText;
    public var price: SFloat;
    public var desc : SText;
}