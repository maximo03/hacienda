const { Pool } = require('pg');

const pool = new Pool({
     
     host:'ec2-54-159-112-44.compute-1.amazonaws.com',
     user:'zpvqzwdssuyuog',
     password:'62105c43bb4b7bb448d6c4cbc63426495ce050573bc9e9821874a923a22e71e0',
     database:'d5l92482u6ts7t',
     port:'5432'
     /*
     host:'localhost',
     user:'postgres',
     password:'maximonestor',
     database:'hacienda',
     port:'5432'
      */
});


const getUsers = async (req,res) => {
    
    const resultSet = await pool.query(`SELECT*FROM afiliado`);
    res.status(200).json(resultSet.rows);
    
};

const getUsersById = async (req,res) => {

    const id=req.params.id;
    const resultSet = await pool.query('SELECT*FROM afiliado WHERE _id = $1',[id]);
    
    res.json(resultSet.rows);

};


const createUser = async (req,res) =>{
    console.log(req.body);
    const {_id,_tipo,_nombre,_correo,_regimen,_actividad,_estado} = req.body;
    const resultSet = await pool.query('select * from InsAfi($1,$2,$3,$4,$5,$6,$7)',
                 [_id,_tipo,_nombre,_correo,_regimen,_actividad,_estado]);
    
    console.log(resultSet);
    res.json({
         message:'User Added SuccesFully',
         body:{
             user:{
                _id,_tipo,_nombre,_correo,_regimen,_actividad,_estado
             }
         }

    });
 

};


const updateUser = async (req,res) => {
   
      const id = req.params.id;
      const {_id,_tipo,_nombre,_correo,_regimen,_actividad,_estado} = req.body;

      const resultSet = await  pool.query('UPDATE afiliado SET _tipo = $1,_nombre = $2,_correo = $3,_regimen = $4,_actividad = $5,_estado = $6 WHERE _id = $7',
                 [_tipo,_nombre,_correo,_regimen,_actividad,_estado,_id]);
      console.log(resultSet)
      res.json('User Updated SuccessFully');

}





const deletUser = async (req,res) => {
    const id=req.params.id;
    const resultSet = await pool.query('DELETE FROM afiliado WHERE _id = $1',[id]);
    console.log(resultSet);
    res.json(`User ${id} as Deleted SuccessFully`);
};

/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/


const createFactura = async (req,res) =>{


    //console.log(req.body);
    const {_factura} = req.body;

    

    /*---------Conversion del XML a JSON------------*/
var parseString = require('xml2js').parseString;
  var xml = _factura;
  parseString(xml, function(error,result){
      if(error){
          console.log('ERROR: '+error);
          return
        }
      // myJson=JSON.stringify(result);
       myJson=result;
      console.dir(myJson);
      
  });

 /*---------FIN Conversion------------*/
  console.log('-------------------------------------------------------------------------------');

  /*---------CAPTURA DE LOS DATOS------------*/ 
  var fact_j = myJson.facturaElectronica.idfact.toString();
  var cedurese_j = myJson.facturaElectronica.reseptor[0].Identificacion[0].numero.toString();
  var nombre_j = myJson.facturaElectronica.reseptor[0].nombre.toString();
  var pago_j= myJson.facturaElectronica.emisor[0].nombre.toString();
  var monto_j= myJson.facturaElectronica.TotalComprobante.toString();
  var fecha_j= myJson.facturaElectronica.fecha.toString();
  var ceduemi_j= myJson.facturaElectronica.emisor[0].Identificacion[0].numero.toString();
  var publickey_j= myJson.facturaElectronica.otrosContenidos[0].Signature[0].SignatureValue.toString();
  var firma_j= myJson.facturaElectronica.otrosContenidos[0].Signature[0].KeyInfo[0].X509Data[0].X509Certificate.toString();
 
   //console.log(fact_j);
   //console.log(cedurese_j);
   //console.log(nombre_j);
   //console.log(pago_j);
   //console.log(monto_j);
   //console.log(fecha_j);
   //console.log(ceduemi_j);
   //console.log(publickey_j);
   //console.log("----------------------------------------------");
   //console.log(firma_j);


    const resultSet = await pool.query('select * from InsFact($1,$2,$3,$4,$5,$6,$7)',
                 [fact_j,cedurese_j,nombre_j,pago_j,monto_j,fecha_j,_factura]);
    
    console.log(resultSet);
    res.json({
         message:'Factura Added SuccesFully',
         body:{
              Acuse:"<?xml version='1.0' encoding='UTF-8'?><MensajeHacienda><Factura>"+fact_j+"</Factura> <NombreEmisor>"+pago_j+"</NombreEmisor> <NumeroCedulaEmisor>"+ceduemi_j+"</NumeroCedulaEmisor> <NombreReceptor>"+nombre_j+"</NombreReceptor> <NumeroCedulaReceptor>"+cedurese_j+"</NumeroCedulaReceptor> <DetalleMensaje>Facturacion completada, su transación se encuentra en las bases de dayos de maxihacienda</DetalleMensaje> <TotalFactura>"+monto_j+"</TotalFactura><otrosContenidos><Signature><SignatureValue>"+publickey_j+"</SignatureValue><KeyInfo><X509Data><X509Certificate>"+firma_j+"</X509Certificate></X509Data></KeyInfo</Signature></otrosContenidos> </MensajeHacienda>"
         }

    });
 

};

/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/


const getFactUserId = async (req,res) => {

    const id=req.params.id;
    const resultSet = await pool.query('select _clave,_nombre,_id,_pago,_monto,_fecha,_factura from factura where _id= $1',[id]);
    
    res.json(resultSet.rows);

};

/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/



const getFact = async (req,res) => {

    const resultSet = await pool.query('SELECT * FROM  factura');
    res.json(resultSet.rows);

};

/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/

const getFactSimpleId = async (req,res) => {

    const id=req.params.id;
    const resultSet = await pool.query('select _clave,_nombre,_id,_pago,_monto,_fecha from factura where _id= $1',[id]);
    
    res.json(resultSet.rows);

};

/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/



const getFactSimple = async (req,res) => {

    const resultSet = await pool.query('SELECT _clave,_nombre,_id,_pago,_monto,_fecha FROM  factura');
    res.json(resultSet.rows);

};

/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/

const getFactClave = async (req,res) => {

    const id=req.params.id;
    const resultSet = await pool.query('select _clave,_nombre,_id,_pago,_monto,_fecha from factura where _clave= $1',[id]);
    
    res.json(resultSet.rows);

};


/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/

const getXML = async (req,res) => {

    const id=req.params.id;
    const resultSet = await pool.query('select _factura from factura where _clave= $1',[id]);
    
    res.json(resultSet.rows);

};


/*//////////////////////////////////////////////////////////////////////////////////////////////////////*/



module.exports = {
     getUsers,
     getUsersById,
     createUser,
     updateUser,
     deletUser,
     createFactura,
     getFactUserId,
     getFact,
     getFactSimpleId,
     getFactSimple,
     getFactClave,
     getXML

}
