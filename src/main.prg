
#include "hdroidgui.ch"

FUNCTION HDroidMain

   LOCAL oWnd, oLayV, oLayH, oBrw, oBtn1, oBtn2, cPath
   LOCAL i, arr := {"Petr","Fedor","Alexander","Viktor","Nikolay","Ivan","Anton", ;
      "Boris","Alexey","Andrey","Konstantin","Oleg","Igor","Pavel","Sergey","Mikhail","Dmitry", ;
      "Artem","Nikita","Ilya","Vladimir","Vyacheslav","Efim","Lev","Roman","Semen","Miron","Matvey","Leonid"}

   INIT WINDOW oWnd TITLE "Browse" ON EXIT {||dbCloseAll()}

   MENU
      MENUITEM "Exit" ACTION hd_calljava_s_v("exit:")
   ENDMENU

   BEGIN LAYOUT oLayV SIZE MATCH_PARENT,MATCH_PARENT

   cPath := hd_HomeDir()
   RDDSETDEFAULT( "DBFCDX" )
   IF !File( cPath+"testa.dbf" )
      dbCreate( cPath+"testa", { {"NAME","C",10,0}, {"NUM","N",4,0}, {"INFO","C",32,0}, {"DINFO","D",8,0} } )

      USE ( cPath+"testa" ) New EXCLUSIVE
      FOR i := 1 TO Len(arr)
         APPEND BLANK
         REPLACE NAME WITH arr[i], NUM WITH 1000+i, INFO WITH "Record number "+Ltrim(Str(i)), DINFO WITH Date()+i
      NEXT
   ELSE
      USE ( cPath+"testa" ) New EXCLUSIVE
   ENDIF
   GO TOP

   IF !Empty( Alias() )
      
      BROWSE oBrw DBF Alias() HSCROLL SIZE MATCH_PARENT, 0 ;
         ON CLICK {|o,n|hd_toast("Row: "+Ltrim(Str(n))+": "+Trim((o:data)->NAME)+Chr(10)+Dtoc((o:data)->DINFO))}

      oBrw:nRowHeight := 40
      oBrw:AddColumn( HDColumn():New( {|o|(o:data)->NAME}, 120 ) )
      oBrw:AddColumn( HDColumn():New( {|o|Str((o:data)->NUM,4)}, 120 ) )
      oBrw:AddColumn( HDColumn():New( {|o|(o:data)->INFO}, 180 ) )

   ENDIF

   BEGIN LAYOUT oLayH HORIZONTAL SIZE MATCH_PARENT,WRAP_CONTENT

      BUTTON oBtn1 TEXT "Add record" ;
            ON CLICK {||EditRec( oBrw,.T. )}
      BUTTON oBtn2 TEXT "Refresh" ;
            ON CLICK {||oBrw:Refresh()}

   END LAYOUT oLayH

   END LAYOUT oLayV

   ACTIVATE WINDOW oWnd

   RETURN NIL

STATIC FUNCTION EditRec( oBrw,lNew )

   LOCAL oWnd, oLayV, oBtn1, oBtn2, oEdit1, oEdit2, oEdit3, oEdit4

   INIT WINDOW oWnd TITLE Iif( lNew, "Add record", "Edit record" )

   BEGIN LAYOUT oLayV SIZE MATCH_PARENT,MATCH_PARENT

   EDITBOX oEdit1 HINT "Name"
   EDITBOX oEdit2 HINT "Number"
   EDITBOX oEdit3 HINT "Info"
   EDITBOX oEdit4 HINT "Date"

   BEGIN LAYOUT oLayH HORIZONTAL SIZE MATCH_PARENT,WRAP_CONTENT

      BUTTON oBtn1 TEXT "Ok" ;
            ON CLICK {||Addrec(oBrw),hd_calljava_s_v("finish:")}

      BUTTON oBtn2 TEXT "Cancel" ;
            ON CLICK {||hd_calljava_s_v("finish:")}

   END LAYOUT oLayH

   END LAYOUT oLayV

   ACTIVATE WINDOW oWnd

   RETURN NIL

STATIC FUNCTION AddRec( oBrw )

   APPEND BLANK
   REPLACE NAME WITH "newname", NUM WITH 500

   RETURN NIL

