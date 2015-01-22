/**
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */
package ti.light;

import org.appcelerator.kroll.KrollModule;
import org.appcelerator.kroll.annotations.Kroll;
import android.os.Build;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.kroll.common.Log;

import android.content.pm.PackageManager;
import android.hardware.Camera;
import android.hardware.Camera.Parameters;

@Kroll.module(name="Tilight", id="ti.light")
public class TilightModule extends KrollModule
{

	// Standard Debugging variables
	private static final String TAG = "TilightModule";
	//flag to detect flash is on or off
	private boolean isLighOn = false;
	//Is supported Results
	private static boolean isSupport = false;
	private Camera camera  = null;
	
	public TilightModule()
	{
		super();
	}

	@Kroll.onAppCreate
	public static void onAppCreate(TiApplication app)
	{		
		PackageManager pm = app.getApplicationContext().getPackageManager();
		// if device support camera?
		isSupport = pm.hasSystemFeature(PackageManager.FEATURE_CAMERA);
	}

	@Kroll.method
	public boolean isSupported()
	{
		return isSupport;
	}

	@Kroll.method
	public boolean isOn()
	{
		return isLighOn;
	}
	
	@Kroll.method
	public void turnOn()
	{
		if(!isLighOn){
			toggle();
		}
	}
	
	@Kroll.method
	public void turnOff()
	{
		if(isLighOn){
			toggle();
		}
	}
	
	// Methods
	@Kroll.method
	public void toggle()
	{
		if(!isSupport){
			Log.d(TAG, "Camera not supported");
			return;
		}
		
		if(camera==null){
			camera = Camera.open();							
		}	
                
                if (Build.VERSION.SDK_INT >= 11) {
		   camera.setPreviewTexture(new SurfaceTexture(0));
                }
                
		final Parameters p = camera.getParameters();
		
		if (isLighOn) {			 
			p.setFlashMode(Parameters.FLASH_MODE_OFF);
			camera.setParameters(p);
			camera.setPreviewCallback(null);
			camera.stopPreview();
			camera.release();
			isLighOn = false;
			Log.i(TAG, "torch is turn off!");
		} else {			
			p.setFlashMode(Parameters.FLASH_MODE_TORCH);
			camera.setParameters(p);
			camera.startPreview();
			isLighOn = true;
			Log.i("info", "torch is turn on!");
		}

	}
	
}

