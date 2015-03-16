package su.harbour.hddbf;

import android.app.Activity;
import android.os.Bundle;
import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import su.harbour.hDroidGUI.*;

public class DopActivity extends Activity {

   private static View mainView;
   private static String sId;

   @Override
   protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);

      Intent intent = getIntent();
      String sAct = intent.getStringExtra("sact");
      sId = intent.getStringExtra("sid");

      mainView = MainApp.harb.createAct( this, sAct );
      setContentView( mainView );
      MainApp.harb.hrbCall( "HD_INITWINDOW",sId );
   }

   @Override
   protected void onDestroy() {
      super.onDestroy();

      MainApp.harb.closeAct( sId );
   }
   @Override
   protected void onResume() {
       super.onResume();

      MainApp.harb.setContext( this,mainView );
   }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
       MainApp.harb.SetMenu( menu );
       return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
       MainApp.harb.onMenuSel( item.getItemId() );
       return true;
    }


}
