<h1>Ti.Light</h1>

The Ti.Light project is a sample on how to create a flashlight module.  This project was created for a TiConf US 2013 demonstration.

<h2>Before you start</h2>
* These are iOS and Android native modules designed to work with Titanium SDK 3.1.0.GA
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the compiled release</h2>

Download the platform you wish to use:

* [iOS Dist](https://github.com/benbahrenburg/Ti.Light/tree/master/iOS/dist)
* [Android Dist] (https://github.com/benbahrenburg/Ti.Light/tree/master/Android/dist)

<h2>Building from source?</h2>

If you are building from source you will need to do the following:

Import the project into Xcode:

* Modify the titanium.xcconfig file with the path to your Titanium installation

Import the project into Eclipse:

* Update the .classpath
* Update the build properties

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the ti.light module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<h2>Example</h2>
<pre><code>
var torch = require('ti.light');
Ti.API.info("module is => " + torch);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'#fff'
});

var button = Ti.UI.createButton({
	title:'Click to toggle',
	height:'80dp', width:Ti.UI.FILL, top:40
});		
win.add(button);

button.addEventListener('click',function(d){
	torch.toggle();
})	
	
win.open();
</code></pre>

<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).
