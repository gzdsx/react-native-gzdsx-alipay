using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Alipay.RNAlipay
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNAlipayModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNAlipayModule"/>.
        /// </summary>
        internal RNAlipayModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNAlipay";
            }
        }
    }
}
