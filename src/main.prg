
#include "hdroidgui.ch"

FUNCTION HDroidMain

   Local oWnd, oLayV, oBrw, cPath
   Local i, arr := {"Petr","Fedor","Alexander","Viktor","Nikolay","Ivan","Anton", ;
      "Boris","Alexey","Andrey","Konstantin","Oleg","Igor","Pavel","Sergey","Mikhail","Dmitry", ;
      "Artem","Nikita","Ilya","Vladimir","Vyacheslav","Efim","Lev","Roman","Semen","Miron","Matvey","Leonid"}

   INIT WINDOW oWnd TITLE "Browse" ON EXIT {||dbCloseAll()}

   MENU
      MENUITEM "Exit" ACTION hd_calljava_s_v( "exit:")
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
      
      BROWSE oBrw DBF Alias() HSCROLL ON CLICK {|o,n|hd_toast("Row: "+Ltrim(Str(n))+": "+Trim((o:data)->NAME)+Chr(10)+Dtoc((o:data)->DINFO))}

      oBrw:nRowHeight := 40
      oBrw:AddColumn( HDColumn():New( {|o|(o:data)->NAME}, 120 ) )
      oBrw:AddColumn( HDColumn():New( {|o|Str((o:data)->NUM,4)}, 120 ) )
      oBrw:AddColumn( HDColumn():New( {|o|(o:data)->INFO}, 180 ) )

   ENDIF

   END LAYOUT oLayV

   ACTIVATE WINDOW oWnd

   RETURN NIL
