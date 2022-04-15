const { Router } = require("express");
const router = Router();
const connection = require("../db/db");

// Peticion GET (SELECT)

router.get("/sedes", async (req, res) => {
  try {
    const [result] = await connection.query("SELECT * FROM sedes");
    return res.status(200).json(result);
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Internal server error!" });
  }
});

// Peticion POST (INSERT INTO)

// router.post("/sedes", async (req, res) => {
//     try {
//         const   { nombre, calle, carrera, nomenclatura, barrio, ciudad, descripcion } = req.body;

//         console.log(req.body);
//         await connection.query(`
//             INSERT INTO sedes(nombre, calle, carrera, nomenclatura, barrio, ciudad, descripcion)
//             VALUES('${nombre}', '${calle}', '${carrera}', '${nomenclatura}', '${barrio}', '${ciudad}', '${descripcion}');
//         `);
//         const [result] = await connection.query(`SELECT * FROM sedes WHERE nombre = '${nombre}'` );
//         return res.status(200).json(result);

//     } catch (error) {
//       console.log(error);
//       res.status(500).json({ error: "Internal server error!" });
//     }
// });

// consulta precompilada (otra forma mas sencila de hacer elmetodopost)
router.post("/sedes", async (req, res) => {
  try {
    const campos = Object.keys(req.body); //para capturar los campos del objeto
    await connection.query(`
            INSERT INTO sedes (${campos.join()}) 
            VALUES(?, ?, ?, ?, ?, ?, ?);
        `, Object.values(req.body)); // para ponerlos valores en los campos que tienen '?'

    return res.status(200).json('Se agrego correctamente');
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Internal server error!" });
  }
});

// peticion PUT 
router.put("/sedes/:id", async (req, res) => {
  try {
    const { nombre, calle, carrera, nomenclatura, barrio, ciudad, descripcion } = req.body;
    if(!nombre || !calle || !carrera || !nomenclatura || !barrio || !ciudad || !descripcion){
      res.status(409).send({ error: "confict" });
    }else{
      const {id} = req.params;
      const fields = Object.keys(req.body);
      const fieldsQuery = fields.map(field => {
        if(typeof req.body[`${field}`] === 'string'){
          return `${field} = '${req.body[`${field}`]}'`;
        }else{
          return `${field} = ${req.body[`${field}`]}`;
        }
      });
    }
    await connection.query(`UPDATE sedes SET ${fieldsQuery.join()} WHERE id = ${id}`);
    res.status(200).json('El campo se actualizo correctamente');

  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Internal server error!" });
  }
});

// Peticion PATCH

router.patch("/sedes/:id", async (req, res) => {
  try {
    const {id} = req.params;
    const fields = Object.keys(req.body);
    const fieldsQuery = fields.map(field => {
      if(typeof req.body[`${field}`] === 'string'){
        return `${field} = '${req.body[`${field}`]}'`;
      }else{
        return `${field} = ${req.body[`${field}`]}`;
      }
    });

    await connection.query(`UPDATE sedes SET ${fieldsQuery.join()} WHERE id = ${id}`);
    res.status(200).json('El campo se actualizo correctamente');

  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Internal server error!" });
  }
});

// DELETE 

router.delete('/sedes/:id', async (req, res) => {
  try {
    const {id} = req.params;
    await connection.query(`DELETE FROM sedes WHERE id = ${id} `);
    res.status(200).json('Registro eliminado correctamente');
    
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: "Internal server error!" });
  }
})

module.exports = router;
