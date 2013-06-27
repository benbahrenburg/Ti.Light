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
