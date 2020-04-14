const {Router}= require('express');
const router = Router();

const {getUsers,createUser,getUsersById,deletUser,updateUser,createFactura,getFactUserId,getFact,getFactSimpleId,getFactSimple,getFactClave,getXML} = require('../controllers/index.controller');

router.get('/users',getUsers);
router.get('/users/:id',getUsersById);

router.post('/users',createUser);
router.delete('/users/:id',deletUser);
router.put('/users/:id',updateUser);

router.post('/factura',createFactura);

router.get('/factura/:id',getFactSimpleId);
router.get('/factura',getFactSimple);

router.get('/facturall/:id',getFactUserId);
router.get('/facturall',getFact);

router.get('/visfactura/:id',getFactClave);
router.get('/visxml/:id',getXML);


module.exports = router;