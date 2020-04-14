create table afiliado(
_id varchar(20) not null primary key,
_tipo char(1) not null,
_nombre varchar(100) not null,
_correo varchar(100) not null,
_regimen char(1) not null,
_actividad varchar(100)not null,
_estado char(1) not null
)

create table factura(
_clave  varchar(100) not null primary key,
_id     varchar(20)  not null references afiliado,
_nombre varchar(100) not null,
_pago   varchar(100) not null,
_monto  numeric(18,2)not null,
_fecha  date          not null,
_factura xml not null
)

select*from afiliado;
select*from factura; 
select * from BusFacIdUser('60345129');

select _clave,_nombre,_pago,_monto,_fecha from factura where _id='60345129';

--/////////////////////////////////////////////////////////////////////////////////////////////--
CREATE FUNCTION InsAfi(Qid varchar(20),
                         Qtipo char(1),
                         Qnombre varchar(100),
                         Qcorreo varchar(100),
                         Qregimen char(1),
                         Qactividad varchar(100),
                         Qestado char(1) )

  RETURNS void 
       AS $BODY$ 
	         BEGIN
		       INSERT INTO afiliado(_id,_tipo,_nombre,_correo,_regimen,_actividad,_estado) 
			         VALUES(Qid,Qtipo,Qnombre,Qcorreo,Qregimen,Qactividad,Qestado);
			  END;
		   $BODY$ 
LANGUAGE 'plpgsql' VOLATILE COST 100;
--/////////////////////////////////////////////////////////////////////////////////////////////--
--/////////////////////////////////////////////////////////////////////////////////////////////--
CREATE FUNCTION InsFact(Qclave  varchar(100),
                          Qid     varchar(20)  ,
                          Qnombre varchar(100) ,
                          Qpago   varchar(100) ,
                          Qmonto  numeric(18,2),
                          Qfecha  date,
                          Qfactura xml)

  RETURNS void 
       AS $BODY$ 
	         BEGIN
		       INSERT INTO factura(_clave,_id,_nombre,_pago,_monto,_fecha,_factura) 
			         VALUES(Qclave,Qid ,Qnombre,Qpago,Qmonto,Qfecha,Qfactura);
			  END;
		   $BODY$ 
LANGUAGE 'plpgsql' VOLATILE COST 100;
--/////////////////////////////////////////////////////////////////////////////////////////////--
CREATE FUNCTION BusFacIdUser(Qid     varchar(20))

  RETURNS void 
       AS $BODY$ 
	         BEGIN
		          select _clave,_nombre,_pago,_monto,_fecha from factura where _id=Qid;
			  END;
		   $BODY$ 
LANGUAGE 'plpgsql' VOLATILE COST 100;

--/////////////////////////////////////////////////////////////////////////////////////////////--

select * from InsFact('50600155','155822436521','Nestor Maximo Valle Ruiz','AYA',460000,'2020-04-4',
'<?xml version="1.0"?>
<facturaElectronica>
   <clave>50600155</clave>
   <idfact>0001</idfact> 
   <fecha>2020-04-4</fecha>
<emisor>
    <nombre>AYA</nombre>
    <Identificacion>
         <tipo>02</tipo>
         <numero>88888</numero>
    </Identificacion>
      <Ubicacion>
         <provincia>1</provincia>
         <canton>01</canton>
         <distrito>08</distrito>
         <barrio>15</barrio>
         <otros>puntarenas centro</otros>
      </Ubicacion>
       <contacto>
         <codPais>506</codPais>
         <telefono>26611590</telefono>
         <correo>aguaviva@aya.com</correo>
      </contacto>
</emisor>
<reseptor>
      <nombre>nestor maximo valle ruiz</nombre>
      <Identificacion>
         <tipo>01</tipo>
         <numero>155822436521</numero>
      </Identificacion>
     <Contacto>
         <codPais>506</codPais>
         <telefono>85034578</telefono>
      </Contacto>
</reseptor>
<CondicionVenta>01</CondicionVenta>
<MedioPago>01</MedioPago>
<Detalle>
     <LineaDetalle>
       <numLinea>1</numLinea>
       <codps>003</codps>
       <cantidad>1</cantidad>
       <descripcion>pago de agua</descripcion>
       <precio>40000</precio>
       <Impuesto>
          <codigo>01</codigo>
          <codTarifa>08</codTarifa>
          <tarifa>13.0</tarifa>
          <monto>46000</monto>
        </Impuesto>
        <MontoTotalLinea>46000</MontoTotalLinea>
     </LineaDetalle>
</Detalle>
<TotalComprobante>460000</TotalComprobante>
<otrosContenidos>
   <ds:Signature>
       <ds:SignatureValue>
            WFVowKkI/No9LEQWLApQo6I12ep1K7QGsx5RtaYQJBy8Bj5q8VUVums/09ARh9WZY
            vctZlZJJC1qIIM/Y0q8B21Nr4RwLfgzUeWiUkaClpMDRHNd1YUHe/yD1+AEvkUuUR
            64LkCtw5wAFTXL2UR98lyXZjVHbzmS4F4pGyxr7IglwpyJUPr9RbBYskGB90pkoBWi
            4qAt+gpQn1KwfmUxIOlmmSAHSMzscH1QTaIz6NevQqFB2zhSNHZiq9KvoTrH07hZRq
            reZiX4qWzVCY8b3792L+6153TbpcYxWvnmJWawpabFVhRCcs+bIEY8P8Ca9ZVCqora
            ZmpKJzB3HX9fXQ==
       </ds:SignatureValue>
           <ds:KeyInfo>
               <ds:X509Data>
                  <ds:X509Certificate>
MIIFKTCCAxGgAwIBAgIGAW4ieA0DMA0GCSqGSIb3DQEBCwUAMFoxCzAJBgNVBAYT
AkNSMR8wHQYDVQQKDBZNSU5JU1RFUklPIERFIEhBQ0lFTkRBMQwwCgYDVQQLDANE
R1QxHDAaBgNVBAMME0NBIFBFUlNPTkEgSlVSSURJQ0EwHhcNMTkxMDMxMTUzODQz
WhcNMjExMDMwMTUzODQzWjCBgzEZMBcGA1UEBRMQQ1BKLTQtMDAwLTA0MjEzOTEL
MAkGA1UEBhMCQ1IxGTAXBgNVBAoMEFBFUlNPTkEgSlVSSURJQ0ExDDAKBgNVBAsM
A0NQSjEwMC4GA1UEAwwnSU5TVElUVVRPIENPU1RBUlJJQ0VOU0UgREUgRUxFQ1RS
SUNJREFEMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAhT1Y28Z4I8He
SVcRt9iYgRkerAA0TnE4MOUPTcVJeJiiykSip/E/P2l8HSk2V2EgukkkusRuurIc
hrqEH/P1FBusE4oufVbLKpMaBN/VFIHQqXuAirbG0k7Th07nXNTVcRSiJuZUqFJw
SleznWCH7nmP7WEzyBSV7QYT/EMlYFsDnTgQt+Rw7h7WxuZowLnYpUo3JOFFnzN+
L27TdJofuLhPmtg1WnJG24BAZsMYNcYjYIIdIB96Xlq8U9cYLz6Mt9hGJRjGu6RM
fHmDKaBnt4Q0j5jCXsSjuGp2Dxu3mkaH4b4FrtB2xzO4jOPVBXwWvDwdnv2UsB1N
FNLOtse8IQIDAQABo4HKMIHHMB8GA1UdIwQYMBaAFDttV/XWfOmeEAIgQeO9GszP
s06VMB0GA1UdDgQWBBTq5drq4GQW/x5bRASXuO/Akl1l0TALBgNVHQ8EBAMCBsAw
EwYDVR0lBAwwCgYIKwYBBQUHAwQwYwYIKwYBBQUHAQEEVzBVMFMGCCsGAQUFBzAC
hkdodHRwczovL3BraS5jb21wcm9iYW50ZXNlbGVjdHJvbmljb3MuZ28uY3IvcHJv
ZC9pbnRlcm1lZGlhdGUtcGotcGVtLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAKDX7
/e1xfYm6ufEE8lnxAVfv76akKcoqjtEry7qGo2eOg5U0rAwX+AUuhSq43RK/O7Ad
/w7omMRKX1aRHoRzVDR3Nd0B4kaMxtROTz+JUy0QM32A06VIfC+2LnH/7m8QWpil
OpQoQ2QOVib2elpWt/fh3drfjMrE1k4A+8kNszZg+YvsnHrJF8p4N9A1FzaF4Aq7
zmN/ri2jKSh/yJXj77Ob6Mwt8IoVVUONTg2aOY2FHhu56IHtZVi9vxyg2rEoM7Wl
jpbv8DGDx5rQlpnAEOunREIS02F3kYHLCEgcWIeJ+hyy3/WRWDhh6Vs/Vv3/2t9m
9waphtPEhkiMwAGIEXPGjYDo6pncKOYe/MThZz5P5gXwzJiezzPK59YVNtw+V1vz
eY/v6xh9JlfKZjZ0HOA1BrAx6nuU8hv4+71l1D/PAGNtzE5e1ysSDdcfEUSr4m/F
z9ykLZC0p8KbytLRc2DonY4gM7rc5TIOoJzd1Ia8GviqFNW7WNWMV/WJzZBEsdIo
T+qlqSwNqX07SrBpHbQCCB3NLER0uYvTdj7g2dWTW2BL9wUx1oYqvVNgR7TCJono
ixIFfAjtrv4S0hNL6BEZ9IQQnXmGB7WIQB7Jo2p1BM9bCZcXQOmXg0chWSV1Dkfx
a6LaoURCezSae15alCh6haFY8hFmbaPr+WXCGMw=
                  </ds:X509Certificate>
               </ds:X509Data>
           </ds:KeyInfo>
   </ds:Signature>
</otrosContenidos>
</facturaElectronica>'); 


select * from InsAfi('155822436521','F','Nestor Maximo Valle Ruiz','nrvalleru@est.utn.ac.cr','S','pintor','A');


truncate table factura;




