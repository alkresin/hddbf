package su.harbour.hddbf;

import android.app.Application;
import su.harbour.hDroidGUI.*;

public class MainApp extends Application {

   public static Harbour harb;

   @Override
   public void onCreate() {
      super.onCreate();

      harb = new Harbour( this );

      harb.Init( false );

   }
}
