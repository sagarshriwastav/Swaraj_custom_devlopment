@ObjectModel.query.implementedBy: 'ABAP:ZPC_HEADERMASTER_CLASS_F4'
define custom entity zpc_headermaster_CDS_F4_1

{
     key zpno        : abap.numc(10);
         zpqlycode   : abap.char(40);
         zpreed1     : abap.numc(4);
         zppicks     : abap.dec(5,2);
         zpreedspace : abap.dec(7,2);
         zdent       : abap.dec(4,2);
         zpdytype    : abap.char(20);
  
}
